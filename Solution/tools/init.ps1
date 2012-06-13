function global:install-redstone {
	$projectName = get-project | select-object -expandproperty ProjectName

	"Setting Up UI"
	install-package shortbus -IncludePrerelease
	install-package structuremap
	install-package StructureMap.MVC3
	install-package WebActivator
	install-package redstone.project.mvc -includePrerelease

	"Setting Up Core"
	add-project Core
	add-projectReference $projectName Core
	install-package shortbus.markers -projectname core -IncludePrerelease	

	
	add-project Data
	add-projectReference Data Core
	install-package -ProjectName Data EntityFramework
	install-package -projectname Data shortbus.markers  -IncludePrerelease
	install-package -projectname Data Newtonsoft.Json	  
	install-package -projectName Data redstone.project.data -includeprerelease
	Enable-Migrations -ProjectName Data

	"Setting up Unit Tests"
	"   Creating project and adding references"
	add-project UnitTests
	add-projectReference UnitTests $projectName
	add-projectReference UnitTests Core
	add-projectReference UnitTests Data

	"   Installing Packages"
	install-package -projectName UnitTests nunit 	
	install-package -projectName UnitTests should 	
	install-package -projectName UnitTests Moq 		
	install-package -projectName UnitTEsts structuremap 	
	install-package -projectName UnitTests redstone.project.unittests -includeprerelease
	install-package -ProjectName UnitTests shortbus -IncludePrerelease

	"Setting up Integration Tests"
	"   Creating project and adding references"
	add-project IntegrationTests
	add-projectReference IntegrationTests $projectName
	add-projectReference IntegrationTests Core
	add-projectReference IntegrationTests Data

	"   Installing Packages"
	install-package -projectName IntegrationTests nunit
	install-package -projectName IntegrationTests should
	install-package -projectName IntegrationTests EntityFramework
	install-package -projectName IntegrationTests EntityFramework.SqlServerCompact
	install-package -projectName IntegrationTests SqlServerCompact
	install-package -projectName IntegrationTests structuremap
	install-package -projectName IntegrationTests redstone.project.integrationtests -includeprerelease
	install-package -ProjectName IntegrationTests shortbus -IncludePrerelease
}