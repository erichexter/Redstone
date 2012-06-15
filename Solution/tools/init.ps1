function global:install-maglev {
	$projectName = get-project | select-object -expandproperty ProjectName
	add-project Core
	add-projectReference $projectName Core
	add-project Data
	add-projectReference Data Core
	add-project UnitTests
	add-projectReference UnitTests $projectName
	add-projectReference UnitTests Core
	add-projectReference UnitTests Data
	add-project IntegrationTests
	add-projectReference IntegrationTests $projectName
	add-projectReference IntegrationTests Core
	add-projectReference IntegrationTests Data

	install-package shortbus -IncludePrerelease
	install-package structuremap
	install-package StructureMap.MVC3
	install-package WebActivator
	install-package maglev.project.mvc -includePrerelease

	install-package EntityFramework -ProjectName Data
	install-package shortbus.markers -projectname Data -IncludePrerelease
	install-package Newtonsoft.Json	 -projectname Data 
	install-package -projectName Data maglev.project.data -includeprerelease
	Enable-Migrations -ProjectName Data

	install-package shortbus.markers -projectname core -IncludePrerelease	

	install-package nunit 		-projectName UnitTests
	install-package should 		-projectName UnitTests
	install-package Moq 		-projectName UnitTests
	install-package structuremap 	-projectName UnitTEsts
	install-package -projectName UnitTests maglev.project.unittests -includeprerelease
	install-package -ProjectName UnitTests shortbus -IncludePrerelease

	install-package -projectName IntegrationTests nunit
	install-package -projectName IntegrationTests should
	install-package -projectName IntegrationTests EntityFramework
	install-package -projectName IntegrationTests EntityFramework.SqlServerCompact
	install-package -projectName IntegrationTests SqlServerCompact
	install-package -projectName IntegrationTests structuremap
	install-package -projectName IntegrationTests maglev.project.integrationtests -includeprerelease
	install-package -ProjectName IntegrationTests shortbus -IncludePrerelease
}