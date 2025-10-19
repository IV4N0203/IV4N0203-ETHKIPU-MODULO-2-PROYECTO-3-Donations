//SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/**
	*@title Contrato Donations
	*@notice Este es un contrato con fines educativos.
	*@author IV4N0203 - AIR.dev
	*@custom:security No usar en producción.
*/
contract Donations {

	/*///////////////////////
					Variables
	///////////////////////*/

	
	///@notice variable inmutable para almacenar la dirección que debe retirar las donaciones
	address immutable i_beneficiario;
	
	///@notice mapping para almacenar el valor donado por usuario
	mapping(address usuario => uint256 valor) public s_donaciones;
	
	/*///////////////////////
						Events
	////////////////////////*/
	///@notice evento emitido cuando se realiza una nueva donación
	event Donations_DonacionRecibida(address donante, uint256 valor);
	///@notice evento emitido cuando se realiza un retiro
	event Donations_RetiroRealizado(address receptor, uint256 valor);
	
	/*///////////////////////
						Errors
	///////////////////////*/
	///@notice error emitido cuando falla una transacción
	error Donations_TransaccionFallida(bytes error);
	///@notice error emitido cuando una dirección diferente al beneficiario intenta retirar
	error Donations_RetiradorNoPermitido(address llamador, address beneficiario);
	///@notice error emitido cuando los fondos son insuficientes
	error Donations_FondosInsuficientes(address receptor, uint256 valor);
	
	/*///////////////////////
					Modificadores
	///////////////////////*/
	///@notice modificador para validar que el llamador sea el beneficiario
	modifier soloBeneficiario() {
		if (msg.sender != i_beneficiario) {
			revert Donations_RetiradorNoPermitido(msg.sender, i_beneficiario);
			}
			_;
		}

	/*///////////////////////
					Functions
	///////////////////////*/
	constructor(address _beneficiario){
    	require(_beneficiario != address(0), "Donations: beneficiario no puede ser address(0)");
    	i_beneficiario = _beneficiario;
	}
	
	
	///@notice función para recibir ether directamente
	receive() external payable{
		require(msg.value > 0, "Donations: valor debe ser mayor a 0");
		s_donaciones[msg.sender] += msg.value;
		emit Donations_DonacionRecibida(msg.sender, msg.value);
	}
	fallback() external payable {
		s_donaciones[msg.sender] += msg.value;
		emit Donations_DonacionRecibida(msg.sender, msg.value);
	}
	
	/**
		*@notice función para recibir donaciones
		*@dev esta función debe sumar el valor donado por cada dirección a lo largo del tiempo
		*@dev esta función debe emitir un evento informando la donación.
	*/
	function donar() external payable {
		require(msg.value > 0, "Donations: valor debe ser mayor a 0");
		s_donaciones[msg.sender] += msg.value;
	
		emit Donations_DonacionRecibida(msg.sender, msg.value);
	}
	
	/**
		*@notice función para retirar el valor de las donaciones
		*@notice el valor del retiro debe ser el valor de la nota enviada
		*@dev solo el beneficiario puede retirar
		*@param _valor El valor de la nota fiscal
	*/
	function retirar(uint256 _valor) external soloBeneficiario {
		require(_valor > 0, "Donations: valor debe ser mayor a 0");

		if (address(this).balance < _valor){
			revert Donations_FondosInsuficientes(address(this), _valor);
		}

		_transferirEth(_valor);

		// Emitir el evento indicando que ese esta realizando un retiro
		emit Donations_RetiroRealizado(i_beneficiario, _valor);
		
	}
	
	/**
		*@notice función privada para realizar la transferencia del ether
		*@param _valor El valor a ser transferido
		*@dev debe revertir si falla
	*/
	function _transferirEth(uint256 _valor) private {
		
		// Intentar transferir el valor del contrato al remitente
		(bool exito, bytes memory error) = msg.sender.call{value: _valor}("");
		
		// Si la transferncia falla, revertir la transaccion con el error
		if(!exito) revert Donations_TransaccionFallida(error);
	}
	
	
}