<?php

include "../Metier/Personne.php";

class PersonneTest extends PHPUnit_Framework_TestCase {

	public function testInsert() {
		// Arrange
		$employe = new Personne();

		// Act
		$employe->setNom("testnom");
		$employe->setPrenom("testprenom");
		$employe->setEmail("testmail@mail.com");
		$employe->setMotDePasse("testmdp");
		$employe->setLigueId("4");
		$employe->setStatutID("3");

		// Assert
		$this->assertTrue($employe->addPersonne());
	}
}