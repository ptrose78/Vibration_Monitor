<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="26008000">
	<Property Name="Localized" Type="Str">Don't Localize</Property>
	<Property Name="NI.LV.All.SaveVersion" Type="Str">Editor Version</Property>
	<Property Name="NI.LV.All.SourceOnly" Type="Bool">true</Property>
	<Property Name="SMProvider.SMVersion" Type="Int">201310</Property>
	<Item Name="My Computer" Type="My Computer">
		<Property Name="IOScan.Faults" Type="Str"></Property>
		<Property Name="IOScan.NetVarPeriod" Type="UInt">100</Property>
		<Property Name="IOScan.NetWatchdogEnabled" Type="Bool">false</Property>
		<Property Name="IOScan.Period" Type="UInt">10000</Property>
		<Property Name="IOScan.PowerupMode" Type="UInt">0</Property>
		<Property Name="IOScan.Priority" Type="UInt">9</Property>
		<Property Name="IOScan.ReportModeConflict" Type="Bool">true</Property>
		<Property Name="IOScan.StartEngineOnDeploy" Type="Bool">false</Property>
		<Property Name="NI.SortType" Type="Int">3</Property>
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="server.tcp.port" Type="Int">0</Property>
		<Property Name="server.tcp.serviceName" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.tcp.serviceName.default" Type="Str">My Computer/VI Server</Property>
		<Property Name="server.vi.callsEnabled" Type="Bool">true</Property>
		<Property Name="server.vi.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="Documentation Images" Type="Folder">
			<Property Name="NI.SortType" Type="Int">0</Property>
			<Item Name="loc_access_task_data.png" Type="Document" URL="../documentation/loc_access_task_data.png"/>
			<Item Name="loc_bundle_new_button_ref.png" Type="Document" URL="../documentation/loc_bundle_new_button_ref.png"/>
			<Item Name="loc_convert_variant.png" Type="Document" URL="../documentation/loc_convert_variant.png"/>
			<Item Name="loc_create_two_queues.png" Type="Document" URL="../documentation/loc_create_two_queues.png"/>
			<Item Name="loc_disable_new_button.png" Type="Document" URL="../documentation/loc_disable_new_button.png"/>
			<Item Name="loc_enqueue_generic_message.png" Type="Document" URL="../documentation/loc_enqueue_generic_message.png"/>
			<Item Name="loc_enqueue_message_with_data.png" Type="Document" URL="../documentation/loc_enqueue_message_with_data.png"/>
			<Item Name="loc_enqueue_priority_message.png" Type="Document" URL="../documentation/loc_enqueue_priority_message.png"/>
			<Item Name="loc_exit_message.png" Type="Document" URL="../documentation/loc_exit_message.png"/>
			<Item Name="loc_message_queue_wire.png" Type="Document" URL="../documentation/loc_message_queue_wire.png"/>
			<Item Name="loc_new_message_diagram.png" Type="Document" URL="../documentation/loc_new_message_diagram.png"/>
			<Item Name="loc_new_task_loop.png" Type="Document" URL="../documentation/loc_new_task_loop.png"/>
			<Item Name="loc_new_task_typedef.png" Type="Document" URL="../documentation/loc_new_task_typedef.png"/>
			<Item Name="loc_open_msg_queue_typedef.png" Type="Document" URL="../documentation/loc_open_msg_queue_typedef.png"/>
			<Item Name="loc_qmh_ignore_errors.png" Type="Document" URL="../documentation/loc_qmh_ignore_errors.png"/>
			<Item Name="loc_queued_message_handler.gif" Type="Document" URL="../documentation/loc_queued_message_handler.gif"/>
			<Item Name="loc_stop_new_mhl.png" Type="Document" URL="../documentation/loc_stop_new_mhl.png"/>
			<Item Name="loc_stop_task.png" Type="Document" URL="../documentation/loc_stop_task.png"/>
			<Item Name="loc_ui_data.png" Type="Document" URL="../documentation/loc_ui_data.png"/>
			<Item Name="loc_value_change_event.png" Type="Document" URL="../documentation/loc_value_change_event.png"/>
			<Item Name="noloc_note.png" Type="Document" URL="../documentation/noloc_note.png"/>
			<Item Name="noloc_tip.png" Type="Document" URL="../documentation/noloc_tip.png"/>
		</Item>
		<Item Name="Python" Type="Folder" URL="../Python">
			<Property Name="NI.DISK" Type="Bool">true</Property>
			<Property Name="NI.SortType" Type="Int">3</Property>
		</Item>
		<Item Name="scratchpads" Type="Folder" URL="../scratchpads">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Support VIs" Type="Folder">
			<Property Name="NI.SortType" Type="Int">3</Property>
			<Item Name="Message Queue.lvlib" Type="Library" URL="../support/Message Queue/Message Queue.lvlib"/>
			<Item Name="User Event - Stop.lvlib" Type="Library" URL="../support/User Event - Stop/User Event - Stop.lvlib"/>
			<Item Name="Check Loop Error.vi" Type="VI" URL="../support/Check Loop Error.vi"/>
			<Item Name="LoadApplicationConfig.vi" Type="VI" URL="../support/LoadApplicationConfig.vi"/>
			<Item Name="Error Handler - Event Handling Loop.vi" Type="VI" URL="../support/Error Handler - Event Handling Loop.vi"/>
			<Item Name="Store_Listener_Ref.vi" Type="VI" URL="../support/Store_Listener_Ref.vi"/>
			<Item Name="Error Handler - Message Handling Loop.vi" Type="VI" URL="../support/Error Handler - Message Handling Loop.vi"/>
		</Item>
		<Item Name="Type Definitions" Type="Folder">
			<Item Name="FGV_Data_Type.ctl" Type="VI" URL="../controls/FGV_Data_Type.ctl"/>
			<Item Name="Telemetry_Data_Type.ctl" Type="VI" URL="../controls/Telemetry_Data_Type.ctl"/>
			<Item Name="Vibration_Profile.ctl" Type="VI" URL="../controls/Vibration_Profile.ctl"/>
			<Item Name="UI_Data_Type.ctl" Type="VI" URL="../controls/UI_Data_Type.ctl"/>
			<Item Name="System_Settings.ctl" Type="VI" URL="../controls/System_Settings.ctl"/>
			<Item Name="Options.ctl" Type="VI" URL="../controls/Options.ctl"/>
			<Item Name="Channels.ctl" Type="VI" URL="../controls/Channels.ctl"/>
			<Item Name="Vibration_Monitor_Config.ctl" Type="VI" URL="../controls/Vibration_Monitor_Config.ctl"/>
			<Item Name="Vibration_Data_Packet.ctl" Type="VI" URL="../controls/Vibration_Data_Packet.ctl"/>
		</Item>
		<Item Name="TCP" Type="Folder" URL="../TCP">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Database" Type="Folder" URL="../Database">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Lib" Type="Folder" URL="../Lib">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Scripts" Type="Folder" URL="../Scripts">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Data Logging" Type="Folder" URL="../Data Logging">
			<Property Name="NI.DISK" Type="Bool">true</Property>
		</Item>
		<Item Name="Acquisition.lvlib" Type="Library" URL="../Acquisition/Acquisition.lvlib"/>
		<Item Name="Main.vi" Type="VI" URL="../Main.vi"/>
		<Item Name="Queued Message Handler Documentation.html" Type="Document" URL="../documentation/Queued Message Handler Documentation.html"/>
		<Item Name="Waveforms.ctl" Type="VI" URL="../controls/Waveforms.ctl"/>
		<Item Name="Acquisition Metrics.ctl" Type="VI" URL="../Acquisition/Acquisition Metrics.ctl"/>
		<Item Name="Alarms.ctl" Type="VI" URL="../Acquisition/Alarms.ctl"/>
		<Item Name="Local_Multi_Point_Task" Type="NI-DAQmx Task">
			<Property Name="\0\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\0\AI.Accel.Sensitivity" Type="Str">100</Property>
			<Property Name="\0\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\0\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\0\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\0\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\0\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\0\AI.Max" Type="Str">5</Property>
			<Property Name="\0\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\0\AI.Min" Type="Str">-5</Property>
			<Property Name="\0\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\0\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\0\Name" Type="Str">Local_Multi_Point_Task/Acceleration_0</Property>
			<Property Name="\0\PhysicalChanName" Type="Str">cDAQ3Mod1/ai0</Property>
			<Property Name="\1\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\1\AI.Accel.Sensitivity" Type="Str">1000</Property>
			<Property Name="\1\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\1\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\1\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\1\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\1\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\1\AI.Max" Type="Str">5</Property>
			<Property Name="\1\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\1\AI.Min" Type="Str">-5</Property>
			<Property Name="\1\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\1\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\1\Name" Type="Str">Local_Multi_Point_Task/Acceleration_1</Property>
			<Property Name="\1\PhysicalChanName" Type="Str">cDAQ3Mod1/ai1</Property>
			<Property Name="\2\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\2\AI.Accel.Sensitivity" Type="Str">1000</Property>
			<Property Name="\2\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\2\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\2\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\2\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\2\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\2\AI.Max" Type="Str">5</Property>
			<Property Name="\2\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\2\AI.Min" Type="Str">-5</Property>
			<Property Name="\2\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\2\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\2\Name" Type="Str">Local_Multi_Point_Task/Acceleration_2</Property>
			<Property Name="\2\PhysicalChanName" Type="Str">cDAQ3Mod1/ai2</Property>
			<Property Name="\3\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\3\AI.Accel.Sensitivity" Type="Str">1000</Property>
			<Property Name="\3\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\3\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\3\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\3\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\3\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\3\AI.Max" Type="Str">5</Property>
			<Property Name="\3\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\3\AI.Min" Type="Str">-5</Property>
			<Property Name="\3\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\3\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\3\Name" Type="Str">Local_Multi_Point_Task/Acceleration_3</Property>
			<Property Name="\3\PhysicalChanName" Type="Str">cDAQ3Mod1/ai3</Property>
			<Property Name="\4\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\4\AI.Accel.Sensitivity" Type="Str">1000</Property>
			<Property Name="\4\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\4\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\4\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\4\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\4\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\4\AI.Max" Type="Str">5</Property>
			<Property Name="\4\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\4\AI.Min" Type="Str">-5</Property>
			<Property Name="\4\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\4\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\4\Name" Type="Str">Local_Multi_Point_Task/Acceleration_4</Property>
			<Property Name="\4\PhysicalChanName" Type="Str">cDAQ3Mod1/ai4</Property>
			<Property Name="\5\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\5\AI.Accel.Sensitivity" Type="Str">1000</Property>
			<Property Name="\5\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\5\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\5\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\5\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\5\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\5\AI.Max" Type="Str">5</Property>
			<Property Name="\5\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\5\AI.Min" Type="Str">-5</Property>
			<Property Name="\5\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\5\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\5\Name" Type="Str">Local_Multi_Point_Task/Acceleration_5</Property>
			<Property Name="\5\PhysicalChanName" Type="Str">cDAQ3Mod1/ai5</Property>
			<Property Name="\6\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\6\AI.Accel.Sensitivity" Type="Str">1000</Property>
			<Property Name="\6\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\6\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\6\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\6\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\6\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\6\AI.Max" Type="Str">5</Property>
			<Property Name="\6\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\6\AI.Min" Type="Str">-5</Property>
			<Property Name="\6\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\6\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\6\Name" Type="Str">Local_Multi_Point_Task/Acceleration_6</Property>
			<Property Name="\6\PhysicalChanName" Type="Str">cDAQ3Mod1/ai6</Property>
			<Property Name="\7\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\7\AI.Accel.Sensitivity" Type="Str">1000</Property>
			<Property Name="\7\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\7\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\7\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\7\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\7\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\7\AI.Max" Type="Str">5</Property>
			<Property Name="\7\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\7\AI.Min" Type="Str">-5</Property>
			<Property Name="\7\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\7\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\7\Name" Type="Str">Local_Multi_Point_Task/Acceleration_7</Property>
			<Property Name="\7\PhysicalChanName" Type="Str">cDAQ3Mod1/ai7</Property>
			<Property Name="Channels" Type="Str">Local_Multi_Point_Task/Acceleration_0, Local_Multi_Point_Task/Acceleration_1, Local_Multi_Point_Task/Acceleration_2, Local_Multi_Point_Task/Acceleration_3, Local_Multi_Point_Task/Acceleration_4, Local_Multi_Point_Task/Acceleration_5, Local_Multi_Point_Task/Acceleration_6, Local_Multi_Point_Task/Acceleration_7</Property>
			<Property Name="Name" Type="Str">Local_Multi_Point_Task</Property>
			<Property Name="SampClk.ActiveEdge" Type="Str">Rising</Property>
			<Property Name="SampClk.Rate" Type="Str">25600</Property>
			<Property Name="SampQuant.SampMode" Type="Str">Continuous Samples</Property>
			<Property Name="SampQuant.SampPerChan" Type="Str">25600</Property>
			<Property Name="SampTimingType" Type="Str">Sample Clock</Property>
		</Item>
		<Item Name="Local_3_Axis_Analysis_Task" Type="NI-DAQmx Task">
			<Property Name="\0\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\0\AI.Accel.Sensitivity" Type="Str">100</Property>
			<Property Name="\0\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\0\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\0\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\0\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\0\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\0\AI.Max" Type="Str">5</Property>
			<Property Name="\0\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\0\AI.Min" Type="Str">-5</Property>
			<Property Name="\0\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\0\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\0\Name" Type="Str">Local_3_Axis_Analysis_Task/Acceleration_0</Property>
			<Property Name="\0\PhysicalChanName" Type="Str">cDAQ3Mod1/ai0</Property>
			<Property Name="\1\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\1\AI.Accel.Sensitivity" Type="Str">1000</Property>
			<Property Name="\1\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\1\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\1\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\1\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\1\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\1\AI.Max" Type="Str">5</Property>
			<Property Name="\1\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\1\AI.Min" Type="Str">-5</Property>
			<Property Name="\1\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\1\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\1\Name" Type="Str">Local_3_Axis_Analysis_Task/Acceleration_1</Property>
			<Property Name="\1\PhysicalChanName" Type="Str">cDAQ3Mod1/ai1</Property>
			<Property Name="\2\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\2\AI.Accel.Sensitivity" Type="Str">1000</Property>
			<Property Name="\2\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\2\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\2\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\2\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\2\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\2\AI.Max" Type="Str">5</Property>
			<Property Name="\2\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\2\AI.Min" Type="Str">-5</Property>
			<Property Name="\2\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\2\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\2\Name" Type="Str">Local_3_Axis_Analysis_Task/Acceleration_2</Property>
			<Property Name="\2\PhysicalChanName" Type="Str">cDAQ3Mod1/ai2</Property>
			<Property Name="Channels" Type="Str">Local_3_Axis_Analysis_Task/Acceleration_0, Local_3_Axis_Analysis_Task/Acceleration_1, Local_3_Axis_Analysis_Task/Acceleration_2</Property>
			<Property Name="Name" Type="Str">Local_3_Axis_Analysis_Task</Property>
			<Property Name="SampClk.ActiveEdge" Type="Str">Rising</Property>
			<Property Name="SampClk.Rate" Type="Str">25600</Property>
			<Property Name="SampQuant.SampMode" Type="Str">Continuous Samples</Property>
			<Property Name="SampQuant.SampPerChan" Type="Str">25600</Property>
			<Property Name="SampTimingType" Type="Str">Sample Clock</Property>
		</Item>
		<Item Name="Local_Basic_Health_Task" Type="NI-DAQmx Task">
			<Property Name="\0\AI.Accel.dBRef" Type="Str">1</Property>
			<Property Name="\0\AI.Accel.Sensitivity" Type="Str">100</Property>
			<Property Name="\0\AI.Accel.SensitivityUnits" Type="Str">mVolts/g</Property>
			<Property Name="\0\AI.Accel.Units" Type="Str">g</Property>
			<Property Name="\0\AI.Excit.Src" Type="Str">Internal</Property>
			<Property Name="\0\AI.Excit.Val" Type="Str">0.002</Property>
			<Property Name="\0\AI.Excit.VoltageOrCurrent" Type="Str">Current</Property>
			<Property Name="\0\AI.Max" Type="Str">5</Property>
			<Property Name="\0\AI.MeasType" Type="Str">Accelerometer</Property>
			<Property Name="\0\AI.Min" Type="Str">-5</Property>
			<Property Name="\0\AI.TermCfg" Type="Str">Pseudodifferential</Property>
			<Property Name="\0\ChanType" Type="Str">Analog Input</Property>
			<Property Name="\0\Name" Type="Str">Local_Basic_Health_Task/Acceleration</Property>
			<Property Name="\0\PhysicalChanName" Type="Str">cDAQ3Mod1/ai0</Property>
			<Property Name="Channels" Type="Str">Local_Basic_Health_Task/Acceleration</Property>
			<Property Name="Name" Type="Str">Local_Basic_Health_Task</Property>
			<Property Name="SampClk.ActiveEdge" Type="Str">Rising</Property>
			<Property Name="SampClk.Rate" Type="Str">25600</Property>
			<Property Name="SampQuant.SampMode" Type="Str">Continuous Samples</Property>
			<Property Name="SampQuant.SampPerChan" Type="Str">25600</Property>
			<Property Name="SampTimingType" Type="Str">Sample Clock</Property>
		</Item>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build">
			<Item Name="Main Application" Type="EXE">
				<Property Name="App_copyErrors" Type="Bool">true</Property>
				<Property Name="App_INI_aliasGUID" Type="Str">{51D186D8-2FD9-4F4B-8F36-40D68E57FFBC}</Property>
				<Property Name="App_INI_GUID" Type="Str">{F8BAE070-8383-465E-800B-3DF9D752A65B}</Property>
				<Property Name="App_serverConfig.httpPort" Type="Int">8002</Property>
				<Property Name="App_serverType" Type="Int">1</Property>
				<Property Name="Bld_buildCacheID" Type="Str">{96FCFFEE-92FF-41D7-8A5C-2E1B7D4F08B1}</Property>
				<Property Name="Bld_buildSpecName" Type="Str">Main Application</Property>
				<Property Name="Bld_excludeLibraryItems" Type="Bool">true</Property>
				<Property Name="Bld_excludePolymorphicVIs" Type="Bool">true</Property>
				<Property Name="Bld_localDestDir" Type="Path">../builds/NI_AB_PROJECTNAME/Main Application</Property>
				<Property Name="Bld_localDestDirType" Type="Str">relativeToCommon</Property>
				<Property Name="Bld_modifyLibraryFile" Type="Bool">true</Property>
				<Property Name="Bld_previewCacheID" Type="Str">{9236DFC5-A1BE-45C5-93F4-A12737594CB8}</Property>
				<Property Name="Bld_version.major" Type="Int">1</Property>
				<Property Name="Destination[0].destName" Type="Str">Main.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../builds/NI_AB_PROJECTNAME/Main Application/Main.exe</Property>
				<Property Name="Destination[0].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../builds/NI_AB_PROJECTNAME/Main Application/data</Property>
				<Property Name="DestinationCount" Type="Int">2</Property>
				<Property Name="Source[0].itemID" Type="Str">{E7BFF366-DAB8-43B4-AA23-0662F14B8EC9}</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/My Computer/Main.vi</Property>
				<Property Name="Source[1].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="SourceCount" Type="Int">2</Property>
				<Property Name="TgtF_fileDescription" Type="Str">Main Application</Property>
				<Property Name="TgtF_internalName" Type="Str">Main Application</Property>
				<Property Name="TgtF_legalCopyright" Type="Str">Copyright © 2012 </Property>
				<Property Name="TgtF_productName" Type="Str">Main Application</Property>
				<Property Name="TgtF_targetfileGUID" Type="Str">{8D31CF1E-BFEE-4FAB-AC90-991853A95B09}</Property>
				<Property Name="TgtF_targetfileName" Type="Str">Main.exe</Property>
			</Item>
		</Item>
	</Item>
</Project>
