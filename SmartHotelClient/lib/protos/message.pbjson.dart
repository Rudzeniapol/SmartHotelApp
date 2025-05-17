//
//  Generated code. Do not modify.
//  source: lib/protos/message.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use statusesDescriptor instead')
const Statuses$json = {
  '1': 'Statuses',
  '2': [
    {'1': 'OK', '2': 0},
    {'1': 'Error', '2': 1},
  ],
};

/// Descriptor for `Statuses`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List statusesDescriptor = $convert.base64Decode(
    'CghTdGF0dXNlcxIGCgJPSxAAEgkKBUVycm9yEAE=');

@$core.Deprecated('Use lighStatesDescriptor instead')
const LighStates$json = {
  '1': 'LighStates',
  '2': [
    {'1': 'On', '2': 0},
    {'1': 'Off', '2': 1},
  ],
};

/// Descriptor for `LighStates`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List lighStatesDescriptor = $convert.base64Decode(
    'CgpMaWdoU3RhdGVzEgYKAk9uEAASBwoDT2ZmEAE=');

@$core.Deprecated('Use doorLockStatesDescriptor instead')
const DoorLockStates$json = {
  '1': 'DoorLockStates',
  '2': [
    {'1': 'Open', '2': 0},
    {'1': 'Close', '2': 1},
  ],
};

/// Descriptor for `DoorLockStates`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List doorLockStatesDescriptor = $convert.base64Decode(
    'Cg5Eb29yTG9ja1N0YXRlcxIICgRPcGVuEAASCQoFQ2xvc2UQAQ==');

@$core.Deprecated('Use statesDescriptor instead')
const States$json = {
  '1': 'States',
  '2': [
    {'1': 'LightOn', '2': 0},
    {'1': 'LightOff', '2': 1},
    {'1': 'DoorLockOpen', '2': 2},
    {'1': 'DoorLockClose', '2': 3},
  ],
};

/// Descriptor for `States`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List statesDescriptor = $convert.base64Decode(
    'CgZTdGF0ZXMSCwoHTGlnaHRPbhAAEgwKCExpZ2h0T2ZmEAESEAoMRG9vckxvY2tPcGVuEAISEQ'
    'oNRG9vckxvY2tDbG9zZRAD');

@$core.Deprecated('Use identifyRequestDescriptor instead')
const IdentifyRequest$json = {
  '1': 'IdentifyRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `IdentifyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List identifyRequestDescriptor = $convert.base64Decode(
    'Cg9JZGVudGlmeVJlcXVlc3QSFAoFdG9rZW4YASABKAlSBXRva2Vu');

@$core.Deprecated('Use getStateDescriptor instead')
const GetState$json = {
  '1': 'GetState',
};

/// Descriptor for `GetState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStateDescriptor = $convert.base64Decode(
    'CghHZXRTdGF0ZQ==');

@$core.Deprecated('Use getInfoDescriptor instead')
const GetInfo$json = {
  '1': 'GetInfo',
};

/// Descriptor for `GetInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInfoDescriptor = $convert.base64Decode(
    'CgdHZXRJbmZv');

@$core.Deprecated('Use setStateDescriptor instead')
const SetState$json = {
  '1': 'SetState',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.States', '10': 'state'},
  ],
};

/// Descriptor for `SetState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setStateDescriptor = $convert.base64Decode(
    'CghTZXRTdGF0ZRIdCgVzdGF0ZRgBIAEoDjIHLlN0YXRlc1IFc3RhdGU=');

@$core.Deprecated('Use stateDescriptor instead')
const State$json = {
  '1': 'State',
  '2': [
    {'1': 'light_on', '3': 1, '4': 1, '5': 14, '6': '.LighStates', '10': 'lightOn'},
    {'1': 'door_lock', '3': 2, '4': 1, '5': 14, '6': '.DoorLockStates', '10': 'doorLock'},
    {'1': 'temperature', '3': 3, '4': 1, '5': 2, '10': 'temperature'},
    {'1': 'pressure', '3': 4, '4': 1, '5': 2, '10': 'pressure'},
    {'1': 'humidity', '3': 5, '4': 1, '5': 2, '10': 'humidity'},
  ],
};

/// Descriptor for `State`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stateDescriptor = $convert.base64Decode(
    'CgVTdGF0ZRImCghsaWdodF9vbhgBIAEoDjILLkxpZ2hTdGF0ZXNSB2xpZ2h0T24SLAoJZG9vcl'
    '9sb2NrGAIgASgOMg8uRG9vckxvY2tTdGF0ZXNSCGRvb3JMb2NrEiAKC3RlbXBlcmF0dXJlGAMg'
    'ASgCUgt0ZW1wZXJhdHVyZRIaCghwcmVzc3VyZRgEIAEoAlIIcHJlc3N1cmUSGgoIaHVtaWRpdH'
    'kYBSABKAJSCGh1bWlkaXR5');

@$core.Deprecated('Use infoDescriptor instead')
const Info$json = {
  '1': 'Info',
  '2': [
    {'1': 'ip', '3': 1, '4': 1, '5': 9, '10': 'ip'},
    {'1': 'mac', '3': 2, '4': 1, '5': 9, '10': 'mac'},
    {'1': 'ble_name', '3': 3, '4': 1, '5': 9, '10': 'bleName'},
    {'1': 'token', '3': 4, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `Info`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List infoDescriptor = $convert.base64Decode(
    'CgRJbmZvEg4KAmlwGAEgASgJUgJpcBIQCgNtYWMYAiABKAlSA21hYxIZCghibGVfbmFtZRgDIA'
    'EoCVIHYmxlTmFtZRIUCgV0b2tlbhgEIAEoCVIFdG9rZW4=');

@$core.Deprecated('Use clientMessageDescriptor instead')
const ClientMessage$json = {
  '1': 'ClientMessage',
  '2': [
    {'1': 'get_info', '3': 1, '4': 1, '5': 11, '6': '.GetInfo', '9': 0, '10': 'getInfo'},
    {'1': 'set_state', '3': 2, '4': 1, '5': 11, '6': '.SetState', '9': 0, '10': 'setState'},
    {'1': 'get_state', '3': 3, '4': 1, '5': 11, '6': '.GetState', '9': 0, '10': 'getState'},
  ],
  '8': [
    {'1': 'message'},
  ],
};

/// Descriptor for `ClientMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientMessageDescriptor = $convert.base64Decode(
    'Cg1DbGllbnRNZXNzYWdlEiUKCGdldF9pbmZvGAEgASgLMgguR2V0SW5mb0gAUgdnZXRJbmZvEi'
    'gKCXNldF9zdGF0ZRgCIAEoCzIJLlNldFN0YXRlSABSCHNldFN0YXRlEigKCWdldF9zdGF0ZRgD'
    'IAEoCzIJLkdldFN0YXRlSABSCGdldFN0YXRlQgkKB21lc3NhZ2U=');

@$core.Deprecated('Use controllerResponseDescriptor instead')
const ControllerResponse$json = {
  '1': 'ControllerResponse',
  '2': [
    {'1': 'info', '3': 1, '4': 1, '5': 11, '6': '.Info', '9': 0, '10': 'info'},
    {'1': 'state', '3': 2, '4': 1, '5': 11, '6': '.State', '9': 0, '10': 'state'},
    {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.Statuses', '9': 0, '10': 'status'},
  ],
  '8': [
    {'1': 'response'},
  ],
};

/// Descriptor for `ControllerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controllerResponseDescriptor = $convert.base64Decode(
    'ChJDb250cm9sbGVyUmVzcG9uc2USGwoEaW5mbxgBIAEoCzIFLkluZm9IAFIEaW5mbxIeCgVzdG'
    'F0ZRgCIAEoCzIGLlN0YXRlSABSBXN0YXRlEiMKBnN0YXR1cxgDIAEoDjIJLlN0YXR1c2VzSABS'
    'BnN0YXR1c0IKCghyZXNwb25zZQ==');

