// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract Estudiante {
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping(string => uint8) private notas_materias;
    mapping(uint8 => string) private _materias;
    string[] private materias;

    constructor(
        string memory nombre_,
        string memory apellido_,
        string memory curso_
    ) {
        nombre = nombre;
        apellido = apellido;
        curso = curso;
        _docente = msg.sender;
    }

    function getApellido() public view returns (string memory) {
        return _apellido;
    }

    function getNombre() public view returns (string memory) {
        return _nombre;
    }

    function getNombreCompleto() public view returns (string memory) {
        string memory nombre_completo = string.concat(_nombre, _apellido);
        return nombre_completo;
    }

    function getCurso() public view returns (string memory) {
        return _curso;
    }

    function set_nota_materia(uint8 nota_, string memory materia_) public {
        require(
            msg.sender == _docente,
            "Solo el docente puede modificar las notas"
        );
        if (notas_materias[materia_] == 0) {
            materias.push(materia_);
        }

        notas_materias[materia_] = nota_;
    }

    function get_nota_materia(string memory _materia)
        public
        view
        returns (uint8)
    {
        return notas_materias[_materia];
    }

    function aprobo(string memory _materia) public view returns (bool) {
        uint256 nota = get_nota_materia(_materia);
        if (nota < 60) {
            return false;
        } else if (nota >= 60 || nota < 100) {
            return true;
        }
        return false;
    }

    function getPromedio() public view returns (uint256) {
        uint256 promedio = 0;
        for (uint256 i = 0; i < materias.length; i++) {
            promedio += notas_materias[materias[i]];
        }

        uint256 notasFinales = promedio / materias.length;
        return notasFinales;
    }
} 