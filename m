Content-Type: multipart/mixed; boundary="===============0944810676604225562=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: network_connect crashes
Date: Mon, 05 Apr 2021 12:39:51 -0700
Message-ID: <601b77bfd6a7015c7d959d260fa03bdd40e8884e.camel@gmail.com>
In-Reply-To: <20210405184544.hckhqfpk7mwz66h2@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0944810676604225562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

I think I have a fix for this, but wanted to see if it worked before
sending it out. What's going on is you are trying to connect multiple
times, and the second connect happens before IWD has associated to the
first. This causes an immediate callback which our code did not expect
and you end up with NULL pointers which were assumed to be set. I cant
seem to trigger this with iwctl, probably because my APs are
associating faster than my fingers can type.

Since you are able to trigger this reliably would you mind testing it
out? Attached is the patch.

Thanks,
James

On Mon, 2021-04-05 at 20:45 +0200, Daniel Wagner wrote:
> Hi,
> =

> I was hacking on ConnMan and was able to reliable trigger this crash
> with the current head:
> =

> ++++++++ backtrace ++++++++
> #0  0x7f4e1504e530 in /lib64/libc.so.6
> #1  0x432b54 in network_get_security() at src/network.c:253
> #2  0x416e92 in station_handshake_setup() at src/station.c:937
> #3  0x41a505 in __station_connect_network() at src/station.c:2551
> #4  0x41a683 in station_disconnect_onconnect_cb() at
> src/station.c:2581
> #5  0x40b4ae in netdev_disconnect() at src/netdev.c:3142
> #6  0x41a719 in station_disconnect_onconnect() at src/station.c:2603
> #7  0x41a89d in station_connect_network() at src/station.c:2652
> #8  0x433f1d in network_connect_psk() at src/network.c:886
> #9  0x43483a in network_connect() at src/network.c:1183
> #10 0x4add11 in _dbus_object_tree_dispatch() at ell/dbus-
> service.c:1802
> #11 0x49ff54 in message_read_handler() at ell/dbus.c:285
> #12 0x496d2f in io_callback() at ell/io.c:120
> #13 0x495894 in l_main_iterate() at ell/main.c:478
> #14 0x49599b in l_main_run() at ell/main.c:521
> #15 0x495cb3 in l_main_run_with_signal() at ell/main.c:647
> #16 0x404add in main() at src/main.c:490
> #17 0x7f4e15038b25 in /lib64/libc.so.6
> =

> =

> The sequence which seems to be to trigger it
> =

>   - set autoconnect to a known network
>   - connnect to this network immediately
> =

> I was not sure if setting the autoconnect will trigger the connect or
> not. Anyway, crashing seems a a bit harsh to let me know that me I am
> doing something wrong ;)
> =

> The same crash happened when I blocked the STA from the AP. I've
> collected a pcap as well. Not sure if you need it.
> =

>   https://www.monom.org/data/blocked.pcap
> =

> Thanks,
> Daniel
> =

> ps: note the above call trace, the pcap and the call trace bellow
> are collected from separate crashes.
> =

> =

> (gdb) bt full
> #0  0x000000000043306e in network_get_security (network=3D0x0) at
> src/network.c:253
> No locals.
> #1  0x00000000004172eb in station_handshake_setup (station=3D0x54bf40,
> network=3D0x0, bss=3D0x0) at src/station.c:938
>         security =3D 5553984
>         settings =3D 0x4e8070 <__func__.14>
>         wiphy =3D 0x417de5 <station_enter_state+681>
>         hs =3D 0x7fffffffe710
>         ssid =3D 0x54d6d0 ""
>         eapol_proto_version =3D 0
>         value =3D 0x4e71eb "State"
>         full_random =3D false
>         override =3D false
>         new_addr =3D "\177\000\000QwA"
>         __func__ =3D "station_handshake_setup"
> #2  0x000000000041a9b7 in __station_connect_network
> (station=3D0x54bf40, network=3D0x0, bss=3D0x0) at src/station.c:2553
>         extra_ies =3D 0x7fffffffe810
>         iov_elems =3D 0
>         hs =3D 0x0
>         r =3D 0
>         __func__ =3D "__station_connect_network"
> #3  0x000000000041ab35 in station_disconnect_onconnect_cb
> (netdev=3D0x54b4a0, success=3Dtrue, user_data=3D0x54bf40) at
> src/station.c:2583
>         station =3D 0x54bf40
>         err =3D 0
> #4  0x000000000040b81e in netdev_disconnect (netdev=3D0x54b4a0,
> cb=3D0x41aae8 <station_disconnect_onconnect_cb>, user_data=3D0x54bf40)
>     at src/netdev.c:3242
>         disconnect =3D 0x7fffffffe7d8
>         send_disconnect =3D false
> #5  0x000000000041abcb in station_disconnect_onconnect
> (station=3D0x54bf40, network=3D0x558720, bss=3D0x5593e0, message=3D0x557b=
c0)
>     at src/station.c:2605
> No locals.
> #6  0x000000000041ad60 in station_connect_network (station=3D0x54bf40,
> network=3D0x558720, bss=3D0x5593e0, message=3D0x557bc0)
>     at src/station.c:2653
>         dbus =3D 0x538d00
>         err =3D 2
> #7  0x0000000000434437 in network_connect_psk (network=3D0x558720,
> bss=3D0x5593e0, message=3D0x557bc0) at src/network.c:884
>         station =3D 0x54bf40
>         need_passphrase =3D false
>         __func__ =3D "network_connect_psk"
> #8  0x0000000000434d54 in network_connect (dbus=3D0x538d00,
> message=3D0x557bc0, user_data=3D0x558720) at src/network.c:1183
>         network =3D 0x558720
>         station =3D 0x54bf40
>         bss =3D 0x5593e0
>         __func__ =3D "network_connect"
> #9  0x00000000004ae3f7 in _dbus_object_tree_dispatch (tree=3D0x53bee0,
> dbus=3D0x538d00, message=3D0x557bc0) at ell/dbus-service.c:1802
>         path =3D 0x558c38 "/net/connman/iwd/2/39/41636865726f6e_psk"
>         interface =3D 0x558c88 "net.connman.iwd.Network"
>         member =3D 0x558ca8 "Connect"
>         msg_sig =3D 0x4fadd9 ""
>         sig =3D 0x5464a5 ""
>         node =3D 0x54cd10
>         instance =3D 0x551b70
>         method =3D 0x546490
>         reply =3D 0x0
> #10 0x00000000004a063a in message_read_handler (io=3D0x539df0,
> user_data=3D0x538d00) at ell/dbus.c:285
>         dbus =3D 0x538d00
>         message =3D 0x557bc0
>         header =3D 0x558c20
>         body =3D 0x0
>         header_size =3D 160
>         body_size =3D 0
>         msgtype =3D DBUS_MESSAGE_TYPE_METHOD_CALL
> #11 0x0000000000497415 in io_callback (fd=3D6, events=3D1,
> user_data=3D0x539df0) at ell/io.c:120
>         io =3D 0x539df0
> #12 0x0000000000495f7a in l_main_iterate (timeout=3D-1) at
> ell/main.c:478
>         events =3D {{events =3D 1, data =3D {ptr =3D 0x539e70, fd =3D 548=
0048,
> u32 =3D 5480048, u64 =3D 5480048}}, {events =3D 4, data =3D {ptr =3D 0x53=
9e70, =

>               fd =3D 5480048, u32 =3D 5480048, u64 =3D 5480048}}, {events=
 =3D
> 4, data =3D {ptr =3D 0x539e70, fd =3D 5480048, u32 =3D 5480048, =

>               u64 =3D 5480048}}, {events =3D 5, data =3D {ptr =3D 0x539e7=
0,
> fd =3D 5480048, u32 =3D 5480048, u64 =3D 5480048}}, {events =3D 1, data =
=3D {
>               ptr =3D 0x54ff50, fd =3D 5570384, u32 =3D 5570384, u64 =3D
> 5570384}}, {events =3D 0, data =3D {ptr =3D 0x10, fd =3D 16, u32 =3D 16, =

>               u64 =3D 16}}, {events =3D 4294967224, data =3D {ptr =3D
> 0xffffffff, fd =3D -1, u32 =3D 4294967295, u64 =3D 4294967295}}, {events =
=3D
> 0, =

>             data =3D {ptr =3D 0x0, fd =3D 0, u32 =3D 0, u64 =3D 0}}, {eve=
nts =3D
> 0, data =3D {ptr =3D 0xf7e6334400000000, fd =3D 0, u32 =3D 0, =

>               u64 =3D 17863021339162443776}}, {events =3D 32767, data =3D
> {ptr =3D 0x53e6b0, fd =3D 5498544, u32 =3D 5498544, u64 =3D 5498544}}}
>         data =3D 0x539e70
>         n =3D 0
>         nfds =3D 1
> #13 0x0000000000496081 in l_main_run () at ell/main.c:525
>         timeout =3D -1
> #14 0x0000000000496399 in l_main_run_with_signal (callback=3D0x403a2e
> <signal_handler>, user_data=3D0x0) at ell/main.c:647
>         data =3D 0x53e4e0
>         sigint =3D 0x53e500
>         sigterm =3D 0x53e680
>         result =3D 0
> #15 0x0000000000404add in main (argc=3D2, argv=3D0x7fffffffec58) at
> src/main.c:490
>         enable_dbus_debug =3D false
>         exit_status =3D 1
>         dbus =3D 0x538d00
>         config_dir =3D 0x4e3a51 "/etc/iwd"
>         config_dirs =3D 0x5347a0
>         i =3D 1
>         __func__ =3D "main"
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============0944810676604225562==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-station-fix-crash-with-disconnect_onconnect.patch"

RnJvbSBmMzYyZjRiNmQyZDM2M2ZmMGNjMGU5MzZkMDk4ZGY5ODc0MDE1NWEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW1lcyBQcmVzdHdvb2QgPHByZXN0d29qQGdtYWlsLmNvbT4K
RGF0ZTogTW9uLCA1IEFwciAyMDIxIDEyOjMyOjUwIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gc3Rh
dGlvbjogZml4IGNyYXNoIHdpdGggZGlzY29ubmVjdF9vbmNvbm5lY3QKCklmIHRoZSBzdGF0aW9u
IGhhcyBub3QgYXNzb2NpYXRlZCB5ZXQgbmV0ZGV2IHdpbGwgbm90IHNlbmQgYQpkaXNjb25uZWN0
IGFuZCBlbmQgdXAgY2FsbGluZyB0aGUgY2FsbGJhY2sgaW1tZWRpYXRlbHkuIFN0YXRpb24KYXNz
dW1lcyB0aGUgY2FsbGJhY2sgd2lsbCBoYXBwZW4gYXN5bmNocm9ub3VzbHkgYW5kIGRvZXMgbm90
CnNldCB0aGUgcmVxdWlyZWQgbmV0d29yay9ic3MgZm9yIF9fc3RhdGlvbl9jb25uZWN0X25ldHdv
cmsKd2hpY2ggcmVzdWx0cyBpbiBhIGNyYXNoOgoKKysrKysrKysgYmFja3RyYWNlICsrKysrKysr
CjAgIDB4N2Y0ZTE1MDRlNTMwIGluIC9saWI2NC9saWJjLnNvLjYKMSAgMHg0MzJiNTQgaW4gbmV0
d29ya19nZXRfc2VjdXJpdHkoKSBhdCBzcmMvbmV0d29yay5jOjI1MwoyICAweDQxNmU5MiBpbiBz
dGF0aW9uX2hhbmRzaGFrZV9zZXR1cCgpIGF0IHNyYy9zdGF0aW9uLmM6OTM3CjMgIDB4NDFhNTA1
IGluIF9fc3RhdGlvbl9jb25uZWN0X25ldHdvcmsoKSBhdCBzcmMvc3RhdGlvbi5jOjI1NTEKNCAg
MHg0MWE2ODMgaW4gc3RhdGlvbl9kaXNjb25uZWN0X29uY29ubmVjdF9jYigpIGF0IHNyYy9zdGF0
aW9uLmM6MjU4MQo1ICAweDQwYjRhZSBpbiBuZXRkZXZfZGlzY29ubmVjdCgpIGF0IHNyYy9uZXRk
ZXYuYzozMTQyCjYgIDB4NDFhNzE5IGluIHN0YXRpb25fZGlzY29ubmVjdF9vbmNvbm5lY3QoKSBh
dCBzcmMvc3RhdGlvbi5jOjI2MDMKNyAgMHg0MWE4OWQgaW4gc3RhdGlvbl9jb25uZWN0X25ldHdv
cmsoKSBhdCBzcmMvc3RhdGlvbi5jOjI2NTIKOCAgMHg0MzNmMWQgaW4gbmV0d29ya19jb25uZWN0
X3BzaygpIGF0IHNyYy9uZXR3b3JrLmM6ODg2CjkgIDB4NDM0ODNhIGluIG5ldHdvcmtfY29ubmVj
dCgpIGF0IHNyYy9uZXR3b3JrLmM6MTE4MwoxMCAweDRhZGQxMSBpbiBfZGJ1c19vYmplY3RfdHJl
ZV9kaXNwYXRjaCgpIGF0IGVsbC9kYnVzLXNlcnZpY2UuYzoxODAyCjExIDB4NDlmZjU0IGluIG1l
c3NhZ2VfcmVhZF9oYW5kbGVyKCkgYXQgZWxsL2RidXMuYzoyODUKMTIgMHg0OTZkMmYgaW4gaW9f
Y2FsbGJhY2soKSBhdCBlbGwvaW8uYzoxMjAKMTMgMHg0OTU4OTQgaW4gbF9tYWluX2l0ZXJhdGUo
KSBhdCBlbGwvbWFpbi5jOjQ3OAoxNCAweDQ5NTk5YiBpbiBsX21haW5fcnVuKCkgYXQgZWxsL21h
aW4uYzo1MjEKMTUgMHg0OTVjYjMgaW4gbF9tYWluX3J1bl93aXRoX3NpZ25hbCgpIGF0IGVsbC9t
YWluLmM6NjQ3CjE2IDB4NDA0YWRkIGluIG1haW4oKSBhdCBzcmMvbWFpbi5jOjQ5MAoxNyAweDdm
NGUxNTAzOGIyNSBpbiAvbGliNjQvbGliYy5zby42CgpUbyBmaXggdGhpcywgbW92ZSB0aGUgZGlz
Y29ubmVjdCBjYWxsICphZnRlciogdGhlIG5ldHdvcmsvYnNzIGlzCnNldCwgYW5kIGNsZWFudXAg
aXMgbmVlZGVkIGluIGNhc2UgbmV0ZGV2X2Rpc2Nvbm5lY3QgZmFpbHMuCi0tLQogc3JjL3N0YXRp
b24uYyB8IDE5ICsrKysrKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NyYy9zdGF0aW9uLmMgYi9zcmMv
c3RhdGlvbi5jCmluZGV4IDA2NDg3MmM2Li42Yzk4NDU3NiAxMDA2NDQKLS0tIGEvc3JjL3N0YXRp
b24uYworKysgYi9zcmMvc3RhdGlvbi5jCkBAIC0yNjAyLDEzICsyNjAyLDYgQEAgc3RhdGljIHZv
aWQgc3RhdGlvbl9kaXNjb25uZWN0X29uY29ubmVjdChzdHJ1Y3Qgc3RhdGlvbiAqc3RhdGlvbiwK
IAkJCQkJc3RydWN0IHNjYW5fYnNzICpic3MsCiAJCQkJCXN0cnVjdCBsX2RidXNfbWVzc2FnZSAq
bWVzc2FnZSkKIHsKLQlpZiAobmV0ZGV2X2Rpc2Nvbm5lY3Qoc3RhdGlvbi0+bmV0ZGV2LCBzdGF0
aW9uX2Rpc2Nvbm5lY3Rfb25jb25uZWN0X2NiLAotCQkJCQkJCQlzdGF0aW9uKSA8IDApIHsKLQkJ
bF9kYnVzX3NlbmQoZGJ1c19nZXRfYnVzKCksCi0JCQkJCWRidXNfZXJyb3JfZnJvbV9lcnJubygt
RUlPLCBtZXNzYWdlKSk7Ci0JCXJldHVybjsKLQl9Ci0KIAlpZiAoc3RhdGlvbi0+bmV0Y29uZmln
KQogCQluZXRjb25maWdfcmVzZXQoc3RhdGlvbi0+bmV0Y29uZmlnKTsKIApAQCAtMjYyMCw2ICsy
NjEzLDE4IEBAIHN0YXRpYyB2b2lkIHN0YXRpb25fZGlzY29ubmVjdF9vbmNvbm5lY3Qoc3RydWN0
IHN0YXRpb24gKnN0YXRpb24sCiAJc3RhdGlvbi0+Y29ubmVjdF9wZW5kaW5nX2JzcyA9IGJzczsK
IAogCXN0YXRpb24tPmNvbm5lY3RfcGVuZGluZyA9IGxfZGJ1c19tZXNzYWdlX3JlZihtZXNzYWdl
KTsKKworCWlmIChuZXRkZXZfZGlzY29ubmVjdChzdGF0aW9uLT5uZXRkZXYsIHN0YXRpb25fZGlz
Y29ubmVjdF9vbmNvbm5lY3RfY2IsCisJCQkJCQkJCXN0YXRpb24pIDwgMCkgeworCQlsX2RidXNf
c2VuZChkYnVzX2dldF9idXMoKSwKKwkJCQkJZGJ1c19lcnJvcl9mcm9tX2Vycm5vKC1FSU8sIG1l
c3NhZ2UpKTsKKwkJbF9kYnVzX21lc3NhZ2VfdW5yZWYoc3RhdGlvbi0+Y29ubmVjdF9wZW5kaW5n
KTsKKwkJc3RhdGlvbi0+Y29ubmVjdF9wZW5kaW5nID0gTlVMTDsKKworCQlzdGF0aW9uLT5jb25u
ZWN0X3BlbmRpbmdfbmV0d29yayA9IE5VTEw7CisJCXN0YXRpb24tPmNvbm5lY3RfcGVuZGluZ19i
c3MgPSBOVUxMOworCQlyZXR1cm47CisJfQogfQogCiB2b2lkIHN0YXRpb25fY29ubmVjdF9uZXR3
b3JrKHN0cnVjdCBzdGF0aW9uICpzdGF0aW9uLCBzdHJ1Y3QgbmV0d29yayAqbmV0d29yaywKLS0g
CjIuMjYuMgoK

--===============0944810676604225562==--

