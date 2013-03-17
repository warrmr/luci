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
	translate('The SNMP plugin collects information from network devices, <a href="http://collectd.org/documentation/manpages/collectd-snmp.5.shtml">collectd-snmp(5).</a>'))

-- collectd_snmp config section
s = m:section(NamedSection, "collectd_snmp", "luci_statistics" )

-- collectd_snmp.enable
enable = s:option(Flag, "enable", translate("Enable this plugin"))
enable.default = 0

-- collectd_snmp_data config section
snmp = m:section(TypedSection, "collectd_snmp_data",
	translate("SNMP Data Section"),
	translate("The Data block defines a list of values or a table of values that are to be queried." ))
	snmp.addremove = true
	snmp.anonymous = true
	
-- <Data "std_traffic">
snmp_data_dataname = snmp:option(Value, "DataName", translate("Data Block Name"))
snmp_data_dataname.default = "std_traffic"

-- collectd_snmp_data.type
snmp_data_type = snmp:option(Value, "Type", translate("Type"), translate("collectd's type that is to be used, e. g. 'if_octets' for interface traffic or 'users' for a user count. The types are read from the TypesDB (see <a href='http://collectd.org/documentation/manpages/collectd-snmp.5.shtml'>collectd.conf(5)</a>)."))
snmp_data_type.default = "if_octets"

-- collectd_snmp_data.table
snmp_data_table = snmp:option(ListValue, 'Table', translate('Table'), translate('Define if this is a single list of values or a table of values.'))
snmp_data_table:value("true", translate("True"))
snmp_data_table:value("false", translate("False"))
snmp_data_table.default = "True"

-- collectd_snmp_data.instance
-- Instance "IF-MIB::ifDescr"
snmp_data_instance = snmp:option(Value, 'Instance', translate('Instance'), translate('If Table is set to true, Instance is interpreted as an SNMP-prefix that will return a list of values.'))
snmp_data_instance.default = "IF-MIB::ifDescr"

-- collectd_snmp_data.values
-- Values "IF-MIB::ifInOctets" "IF-MIB::ifOutOctets"
snmp_data_values = snmp:option(Value, 'Values', translate('Values OID'), translate('If Table is set to true, each OID must be the prefix of all the values to query.'))
snmp_data_values.default = '"IF-MIB::ifInOctets" "IF-MIB::ifOutOctets"'

snmp_data_scale = snmp:option(Value, 'Scale', translate('Scale Value'), translate('The gauge-values returned by the SNMP-agent are multiplied by Scale Value.'))
snmp_data_scale.rmempty = true
snmp_data_scale.optional = true

snmp_data_shift = snmp:option(Value, 'Shift', translate('Shift Value'), translate('Shift Value is added to gauge-values returned by the SNMP-agent after they have been multiplied by any Scale value.'))
snmp_data_shift.rmempty = true
snmp_data_shift.optional = true

-- <Host "some.switch.mydomain.org">
-- collectd_snmp_hosts config section
host = m:section(TypedSection, "collectd_snmp_host",
	translate("SNMP Host Section"),
	translate("The Host block defines which hosts to query, which SNMP community and version to use and which of the defined Data to query. The argument passed to the Host block is used as the hostname in the data stored by collectd." ))
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
snmp_host_snmpVersion = host:option(ListValue, "Version", translate("SNMP Version"), translate("Set the SNMP version to use."))
snmp_host_snmpVersion:value("1", translate("v1"))
snmp_host_snmpVersion:value("2", translate("v2c"))
snmp_host_snmpVersion.default = "2"

-- collectd_host_communityString
-- Community "community_string"
snmp_host_communityString = host:option(Value, "Community", translate("Community String"), translate("Pass <i>Community</i> to the host."))
snmp_host_communityString.default = "community_string"

-- collectd_host_trafficName
-- Collect "std_traffic"
snmp_host_trafficName = host:option(Value, "Collect", translate("Collect Data Block"), translate("Defines which values to collect. Data refers to one of the Data block above. Since the config file is read top-down you need to define the data before using it here."))
snmp_host_trafficName.default = "std_traffic"

-- collectd_host_interval
-- Interval 120
snmp__host_interval = host:option(Value, "Interval", translate("Interval (Seconds)"), translate("Collect data from this host every x seconds. This option is meant for devices with not much CPU power, e. g. network equipment such as switches, embedded devices, rack monitoring systems and so on. Since the Step of generated RRD files depends on this setting it's wise to select a reasonable value once and never change it."))
snmp__host_interval.default = "120"

return m
