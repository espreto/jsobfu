# change this to if you copy it from the repo:
# require 'jsobfu'

require_relative '../lib/jsobfu'

source = %Q|
  // some sample javascript code, to demonstrate usage:
  this._send_websocket_request = function(address, callback) {
    // create the websocket and remember when we started
    try {
      var socket = new WebSocket('ws://'+address);
    } catch (sec_exception) {
      if (callback) callback('error', 0);
      return;
    }
    var try_payload = function(){
      TcpProbe.send("\x12\x12\x12\x12\x12\x12\x12\x12\x12"+
                    "\x12\x12\x12\x12\x12\x12\x12\x12\x12"+
                    "\x12\x12\x12\x12\x12\x12\x12\x12\x12");
    }
    // wait a sec, then start the checks
    setTimeout(this.check_socket, 200);
  };
|

puts JSObfu.new(source).obfuscate