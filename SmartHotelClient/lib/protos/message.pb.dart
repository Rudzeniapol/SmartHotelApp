//
//  Generated code. Do not modify.
//  source: lib/protos/message.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'message.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'message.pbenum.dart';

class IdentifyRequest extends $pb.GeneratedMessage {
  factory IdentifyRequest({
    $core.String? token,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  IdentifyRequest._() : super();
  factory IdentifyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IdentifyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IdentifyRequest', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IdentifyRequest clone() => IdentifyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IdentifyRequest copyWith(void Function(IdentifyRequest) updates) => super.copyWith((message) => updates(message as IdentifyRequest)) as IdentifyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IdentifyRequest create() => IdentifyRequest._();
  IdentifyRequest createEmptyInstance() => create();
  static $pb.PbList<IdentifyRequest> createRepeated() => $pb.PbList<IdentifyRequest>();
  @$core.pragma('dart2js:noInline')
  static IdentifyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IdentifyRequest>(create);
  static IdentifyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class GetState extends $pb.GeneratedMessage {
  factory GetState() => create();
  GetState._() : super();
  factory GetState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetState', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetState clone() => GetState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetState copyWith(void Function(GetState) updates) => super.copyWith((message) => updates(message as GetState)) as GetState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetState create() => GetState._();
  GetState createEmptyInstance() => create();
  static $pb.PbList<GetState> createRepeated() => $pb.PbList<GetState>();
  @$core.pragma('dart2js:noInline')
  static GetState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetState>(create);
  static GetState? _defaultInstance;
}

class GetInfo extends $pb.GeneratedMessage {
  factory GetInfo() => create();
  GetInfo._() : super();
  factory GetInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInfo', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInfo clone() => GetInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInfo copyWith(void Function(GetInfo) updates) => super.copyWith((message) => updates(message as GetInfo)) as GetInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInfo create() => GetInfo._();
  GetInfo createEmptyInstance() => create();
  static $pb.PbList<GetInfo> createRepeated() => $pb.PbList<GetInfo>();
  @$core.pragma('dart2js:noInline')
  static GetInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInfo>(create);
  static GetInfo? _defaultInstance;
}

class SetState extends $pb.GeneratedMessage {
  factory SetState({
    States? state,
  }) {
    final $result = create();
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  SetState._() : super();
  factory SetState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetState', createEmptyInstance: create)
    ..e<States>(1, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: States.LightOn, valueOf: States.valueOf, enumValues: States.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetState clone() => SetState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetState copyWith(void Function(SetState) updates) => super.copyWith((message) => updates(message as SetState)) as SetState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetState create() => SetState._();
  SetState createEmptyInstance() => create();
  static $pb.PbList<SetState> createRepeated() => $pb.PbList<SetState>();
  @$core.pragma('dart2js:noInline')
  static SetState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetState>(create);
  static SetState? _defaultInstance;

  @$pb.TagNumber(1)
  States get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(States v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
}

class State extends $pb.GeneratedMessage {
  factory State({
    LighStates? lightOn,
    DoorLockStates? doorLock,
    $core.double? temperature,
    $core.double? pressure,
    $core.double? humidity,
  }) {
    final $result = create();
    if (lightOn != null) {
      $result.lightOn = lightOn;
    }
    if (doorLock != null) {
      $result.doorLock = doorLock;
    }
    if (temperature != null) {
      $result.temperature = temperature;
    }
    if (pressure != null) {
      $result.pressure = pressure;
    }
    if (humidity != null) {
      $result.humidity = humidity;
    }
    return $result;
  }
  State._() : super();
  factory State.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory State.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'State', createEmptyInstance: create)
    ..e<LighStates>(1, _omitFieldNames ? '' : 'lightOn', $pb.PbFieldType.OE, defaultOrMaker: LighStates.On, valueOf: LighStates.valueOf, enumValues: LighStates.values)
    ..e<DoorLockStates>(2, _omitFieldNames ? '' : 'doorLock', $pb.PbFieldType.OE, defaultOrMaker: DoorLockStates.Open, valueOf: DoorLockStates.valueOf, enumValues: DoorLockStates.values)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'temperature', $pb.PbFieldType.OF)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'pressure', $pb.PbFieldType.OF)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'humidity', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  State clone() => State()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  State copyWith(void Function(State) updates) => super.copyWith((message) => updates(message as State)) as State;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static State create() => State._();
  State createEmptyInstance() => create();
  static $pb.PbList<State> createRepeated() => $pb.PbList<State>();
  @$core.pragma('dart2js:noInline')
  static State getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<State>(create);
  static State? _defaultInstance;

  @$pb.TagNumber(1)
  LighStates get lightOn => $_getN(0);
  @$pb.TagNumber(1)
  set lightOn(LighStates v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLightOn() => $_has(0);
  @$pb.TagNumber(1)
  void clearLightOn() => $_clearField(1);

  @$pb.TagNumber(2)
  DoorLockStates get doorLock => $_getN(1);
  @$pb.TagNumber(2)
  set doorLock(DoorLockStates v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDoorLock() => $_has(1);
  @$pb.TagNumber(2)
  void clearDoorLock() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get temperature => $_getN(2);
  @$pb.TagNumber(3)
  set temperature($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTemperature() => $_has(2);
  @$pb.TagNumber(3)
  void clearTemperature() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get pressure => $_getN(3);
  @$pb.TagNumber(4)
  set pressure($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPressure() => $_has(3);
  @$pb.TagNumber(4)
  void clearPressure() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get humidity => $_getN(4);
  @$pb.TagNumber(5)
  set humidity($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHumidity() => $_has(4);
  @$pb.TagNumber(5)
  void clearHumidity() => $_clearField(5);
}

class Info extends $pb.GeneratedMessage {
  factory Info({
    $core.String? ip,
    $core.String? mac,
    $core.String? bleName,
    $core.String? token,
  }) {
    final $result = create();
    if (ip != null) {
      $result.ip = ip;
    }
    if (mac != null) {
      $result.mac = mac;
    }
    if (bleName != null) {
      $result.bleName = bleName;
    }
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  Info._() : super();
  factory Info.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Info.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Info', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'ip')
    ..aOS(2, _omitFieldNames ? '' : 'mac')
    ..aOS(3, _omitFieldNames ? '' : 'bleName')
    ..aOS(4, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Info clone() => Info()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Info copyWith(void Function(Info) updates) => super.copyWith((message) => updates(message as Info)) as Info;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Info create() => Info._();
  Info createEmptyInstance() => create();
  static $pb.PbList<Info> createRepeated() => $pb.PbList<Info>();
  @$core.pragma('dart2js:noInline')
  static Info getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Info>(create);
  static Info? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get ip => $_getSZ(0);
  @$pb.TagNumber(1)
  set ip($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIp() => $_has(0);
  @$pb.TagNumber(1)
  void clearIp() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get mac => $_getSZ(1);
  @$pb.TagNumber(2)
  set mac($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMac() => $_has(1);
  @$pb.TagNumber(2)
  void clearMac() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bleName => $_getSZ(2);
  @$pb.TagNumber(3)
  set bleName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBleName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBleName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get token => $_getSZ(3);
  @$pb.TagNumber(4)
  set token($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearToken() => $_clearField(4);
}

enum ClientMessage_Message {
  getInfo, 
  setState, 
  getState, 
  notSet
}

class ClientMessage extends $pb.GeneratedMessage {
  factory ClientMessage({
    GetInfo? getInfo,
    SetState? setState,
    GetState? getState,
  }) {
    final $result = create();
    if (getInfo != null) {
      $result.getInfo = getInfo;
    }
    if (setState != null) {
      $result.setState = setState;
    }
    if (getState != null) {
      $result.getState = getState;
    }
    return $result;
  }
  ClientMessage._() : super();
  factory ClientMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClientMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ClientMessage_Message> _ClientMessage_MessageByTag = {
    1 : ClientMessage_Message.getInfo,
    2 : ClientMessage_Message.setState,
    3 : ClientMessage_Message.getState,
    0 : ClientMessage_Message.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClientMessage', createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<GetInfo>(1, _omitFieldNames ? '' : 'getInfo', subBuilder: GetInfo.create)
    ..aOM<SetState>(2, _omitFieldNames ? '' : 'setState', subBuilder: SetState.create)
    ..aOM<GetState>(3, _omitFieldNames ? '' : 'getState', subBuilder: GetState.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClientMessage clone() => ClientMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClientMessage copyWith(void Function(ClientMessage) updates) => super.copyWith((message) => updates(message as ClientMessage)) as ClientMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientMessage create() => ClientMessage._();
  ClientMessage createEmptyInstance() => create();
  static $pb.PbList<ClientMessage> createRepeated() => $pb.PbList<ClientMessage>();
  @$core.pragma('dart2js:noInline')
  static ClientMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientMessage>(create);
  static ClientMessage? _defaultInstance;

  ClientMessage_Message whichMessage() => _ClientMessage_MessageByTag[$_whichOneof(0)]!;
  void clearMessage() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  GetInfo get getInfo => $_getN(0);
  @$pb.TagNumber(1)
  set getInfo(GetInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGetInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearGetInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  GetInfo ensureGetInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  SetState get setState => $_getN(1);
  @$pb.TagNumber(2)
  set setState(SetState v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSetState() => $_has(1);
  @$pb.TagNumber(2)
  void clearSetState() => $_clearField(2);
  @$pb.TagNumber(2)
  SetState ensureSetState() => $_ensure(1);

  @$pb.TagNumber(3)
  GetState get getState => $_getN(2);
  @$pb.TagNumber(3)
  set getState(GetState v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGetState() => $_has(2);
  @$pb.TagNumber(3)
  void clearGetState() => $_clearField(3);
  @$pb.TagNumber(3)
  GetState ensureGetState() => $_ensure(2);
}

enum ControllerResponse_Response {
  info, 
  state, 
  status, 
  notSet
}

class ControllerResponse extends $pb.GeneratedMessage {
  factory ControllerResponse({
    Info? info,
    State? state,
    Statuses? status,
  }) {
    final $result = create();
    if (info != null) {
      $result.info = info;
    }
    if (state != null) {
      $result.state = state;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  ControllerResponse._() : super();
  factory ControllerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControllerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ControllerResponse_Response> _ControllerResponse_ResponseByTag = {
    1 : ControllerResponse_Response.info,
    2 : ControllerResponse_Response.state,
    3 : ControllerResponse_Response.status,
    0 : ControllerResponse_Response.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ControllerResponse', createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<Info>(1, _omitFieldNames ? '' : 'info', subBuilder: Info.create)
    ..aOM<State>(2, _omitFieldNames ? '' : 'state', subBuilder: State.create)
    ..e<Statuses>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: Statuses.OK, valueOf: Statuses.valueOf, enumValues: Statuses.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControllerResponse clone() => ControllerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControllerResponse copyWith(void Function(ControllerResponse) updates) => super.copyWith((message) => updates(message as ControllerResponse)) as ControllerResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ControllerResponse create() => ControllerResponse._();
  ControllerResponse createEmptyInstance() => create();
  static $pb.PbList<ControllerResponse> createRepeated() => $pb.PbList<ControllerResponse>();
  @$core.pragma('dart2js:noInline')
  static ControllerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ControllerResponse>(create);
  static ControllerResponse? _defaultInstance;

  ControllerResponse_Response whichResponse() => _ControllerResponse_ResponseByTag[$_whichOneof(0)]!;
  void clearResponse() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Info get info => $_getN(0);
  @$pb.TagNumber(1)
  set info(Info v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  Info ensureInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  State get state => $_getN(1);
  @$pb.TagNumber(2)
  set state(State v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasState() => $_has(1);
  @$pb.TagNumber(2)
  void clearState() => $_clearField(2);
  @$pb.TagNumber(2)
  State ensureState() => $_ensure(1);

  @$pb.TagNumber(3)
  Statuses get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(Statuses v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
