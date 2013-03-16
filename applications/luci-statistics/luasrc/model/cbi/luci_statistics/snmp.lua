--[[
LuCI - Lua Configuration Interface

Copyright © 2011 Manuel Munz <freifunk at somakoma dot de>
Copyright © 2012 David Woodhouse <dwmw2@infradead.org>
Copyright © 2013 Matt Warrillow <mattwarrillow@warrillow.co.uk>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0
]]--

m = Map("luci_statistics",
	translate("SNMP Plugin Configuration"),
	translate("The SNMP plugin collects information from network devices."))

-- collectd_snmp config section
s = m:section(NamedSection, "collectd_snmp", "luci_statistics" )

-- collectd_snmp.enable
enable = s:option(Flag, "enable", translate("Enable this plugin"))
enable.default = 0

-- collectd_snmp_data config section
snmp = m:section(TypedSection, "collectd_snmp_data",
	translate("SNMP Data Section"),
	translate("Here you define the datatypes you wish to collect from your hosts" ))
	snmp.addremove = true
	snmp.anonymous = true
	
-- <Data "std_traffic">
snmp_data_dataname = snmp:option(Value, "DataName", translate("Data Type Name"))
snmp_data_dataname.default = "std_traffic"

-- collectd_snmp_data.type
snmp_data_type = snmp:option(Value, "Type", translate("Type"))
snmp_data_type.default = "if_octets"

-- collectd_snmp_data.table
snmp_data_table = snmp:option(Flag, "Table", translate("Tables Enabled"))
snmp_data_table.enabled="true"
snmp_data_table.disabled="false"

-- collectd_snmp_data.instance
-- Instance "IF-MIB::ifDescr"
snmp_data_instance = snmp:option(Value, "Instance", translate("Instance"))
snmp_data_instance.default = "IF-MIB::ifDescr"

-- collectd_snmp_data.values
-- Values "IF-MIB::ifInOctets" "IF-MIB::ifOutOctets"
snmp_data_values = snmp:option(Value, "Values", translate("Values"))
snmp_data_values.default = '"IF-MIB::ifInOctets" "IF-MIB::ifOutOctets"'

-- </Data>

-- <Host "some.switch.mydomain.org">
-- collectd_snmp_hosts config section

host = m:section(TypedSection, "collectd_snmp_host",
	translate("SNMP Host Section"),
	translate("Here you define the hosts you wish to collect data from" ))
	host.addremove = true
	host.anonymous = true

-- collectd_host_hostname
-- Hostname "some.switch.mydomain.org
snmp_host_hostname = host:option(Value, "Hostname", translate("Hostname"))
snmp_host_hostname.default = "some.switch.mydomain.org"

--collectd_host_address 
-- Address "192.168.0.2"
snmp_host_address = host:option(Value, "Address", translate("Address"))
snmp_host_address.default = "192.168.0.2"

-- collectd_host_snmpVersion
-- Version 1
snmp_host_snmpVersion = host:option(ListValue, "Version", translate("Version"))
snmp_host_snmpVersion:value("1", translate("v1"))
snmp_host_snmpVersion:value("2", translate("v2"))
snmp_host_snmpVersion:value("3", translate("v3"))

-- collectd_host_communityString
-- Community "community_string"
snmp_host_communityString = host:option(Value, "Community", translate("Community"))
snmp_host_communityString.default = "community_string"

-- collectd_host_trafficName
-- Collect "std_traffic"
snmp_host_trafficName = host:option(Value, "Collect", translate("Collect"))
snmp_host_trafficName.default = "std_traffic"

-- collectd_host_interval
-- Interval 120
snmp__host_interval = host:option(Value, "Interval", translate("Interval"))
snmp__host_interval.default = "120"

-- </Host> 

return m
