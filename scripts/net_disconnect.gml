///net_disconnect(key);
globalvar net_peer_key, net_peer_ip, net_peer_port, net_peer_nettype, net_peer_name, net_peer_ping, net_peer_lastping, net_peer_pingrecv, net_peer_type, net_peer_socket;
var key, pos, type;
key = argument0;
pos = ds_list_find_index(net_peer_key, key);
if (pos<0) return -1;
type = ds_list_find_value(net_peer_nettype, pos);

switch (type) {
    case NET_UDP:
        var buffer = ds_list_create();
        net_send(key, MSG_DISCONN, buffer);
        ds_list_destroy(buffer);
    case NET_TCP:
    case NET_TCPRAW:
    case NET_BROADCAST:
        var socket = ds_list_find_value(net_peer_socket, pos);
        network_destroy(socket);
        break;
    case NET_HTTP:
        break;
}

ds_list_delete(net_peer_key, pos);
ds_list_delete(net_peer_ip, pos);
ds_list_delete(net_peer_port, pos);
ds_list_delete(net_peer_nettype, pos);
ds_list_delete(net_peer_name, pos);
ds_list_delete(net_peer_ping, pos);
ds_list_delete(net_peer_lastping, pos);
ds_list_delete(net_peer_pingrecv, pos);
ds_list_delete(net_peer_type, pos);
ds_list_delete(net_peer_socket, pos);
