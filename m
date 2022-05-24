Content-Type: multipart/mixed; boundary="===============0749310720587120034=="
MIME-Version: 1.0
From: =?utf-8?q?Josef_Vyb=C3=ADhal_=3Cjosef_at_vybihal=2Ecz=3E?=
To: iwd at lists.01.org
Subject: eap-tls connects, after 1 hour fails and then connects again
Date: Tue, 24 May 2022 14:29:22 +0200
Message-ID: <2c85a577a3c65e41550ffd52c9ce2ef9ec0f600a.camel@vybihal.cz>

--===============0749310720587120034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, I am facing quite strange (to me) issue with iwd 1.27.

I have an eap-tls profile. I am able to connect with is just fine. But
exactly after one hour, there is reauthentication (guessing the right
term here) for some reason, and it fails, and then immediately after it
there is second one which is successfull. After exactly one hour the
cycle repeats.

Here is log. What stands out to me is "TLS: tls_tx_handshake:890 Sending a =
TLS_CERTIFICATE of 3 bytes". That's super strange, only 3 bytes?

May 24 11:04:33 jv iwd[781]: resolve: /usr/bin/resolvconf exited with statu=
s (256).
May 24 11:04:34 jv iwd[781]: netconfig: Failed to start DHCPv6 client for i=
nterface 5
May 24 12:04:34 jv iwd[781]: EAP server tried method 25 while client was co=
nfigured for method 13
May 24 12:04:34 jv iwd[781]: TLS: tls_tx_handshake:890 Sending a TLS_CLIENT=
_HELLO of 117 bytes
May 24 12:04:34 jv iwd[781]: TLS: l_tls_start:2849 New state TLS_HANDSHAKE_=
WAIT_HELLO
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
SERVER_HELLO of 38 bytes
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_server_hello:1830 Negotiated T=
LS 1.2
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_server_hello:1866 Negotiated T=
LS_ECDHE_RSA_WITH_AES_256_CBC_SHA
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_server_hello:1877 Negotiated C=
ompressionMethod.null
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_server_hello:1880 New state TL=
S_HANDSHAKE_WAIT_CERTIFICATE
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
CERTIFICATE of 1371 bytes
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_certificate:1950 Peer certchai=
n written to /tmp/iwd-tls-debug-server-cert.pem
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_certificate:2044 New state TLS=
_HANDSHAKE_WAIT_KEY_EXCHANGE
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
SERVER_KEY_EXCHANGE of 329 bytes
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_handshake:2443 New state TLS_H=
ANDSHAKE_WAIT_HELLO_DONE
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_ecdhe_server_key_xchg:506 Nego=
tiated secp256r1
May 24 12:04:34 jv iwd[781]: TLS: tls_rsa_verify:213 Peer signature verified
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_ecdhe_server_key_xchg:560 New =
state TLS_HANDSHAKE_WAIT_HELLO_DONE
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
CERTIFICATE_REQUEST of 112 bytes
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
SERVER_HELLO_DONE of 0 bytes
May 24 12:04:34 jv iwd[781]: TLS: tls_tx_handshake:890 Sending a TLS_CERTIF=
ICATE of 3 bytes
May 24 12:04:34 jv iwd[781]: TLS: tls_tx_handshake:890 Sending a TLS_CLIENT=
_KEY_EXCHANGE of 66 bytes
May 24 12:04:34 jv iwd[781]: TLS: tls_tx_handshake:890 Sending a TLS_FINISH=
ED of 12 bytes
May 24 12:04:34 jv iwd[781]: TLS: tls_handle_server_hello_done:2155 New sta=
te TLS_HANDSHAKE_WAIT_CHANGE_CIPHER_SPEC
May 24 12:04:35 jv iwd[781]: EAP completed with eapFail
May 24 12:04:35 jv iwd[781]: TLS: tls_reset_handshake:204 New state TLS_HAN=
DSHAKE_WAIT_START
May 24 12:04:35 jv iwd[781]: 4-Way handshake failed for ifindex: 5, reason:=
 23
May 24 12:04:36 jv iwd[781]: EAP server tried method 25 while client was co=
nfigured for method 13
May 24 12:04:36 jv iwd[781]: TLS: tls_tx_handshake:890 Sending a TLS_CLIENT=
_HELLO of 117 bytes
May 24 12:04:36 jv iwd[781]: TLS: l_tls_start:2849 New state TLS_HANDSHAKE_=
WAIT_HELLO
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
SERVER_HELLO of 38 bytes
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_server_hello:1830 Negotiated T=
LS 1.2
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_server_hello:1866 Negotiated T=
LS_ECDHE_RSA_WITH_AES_256_CBC_SHA
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_server_hello:1877 Negotiated C=
ompressionMethod.null
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_server_hello:1880 New state TL=
S_HANDSHAKE_WAIT_CERTIFICATE
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
CERTIFICATE of 1371 bytes
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_certificate:1950 Peer certchai=
n written to /tmp/iwd-tls-debug-server-cert.pem
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_certificate:2044 New state TLS=
_HANDSHAKE_WAIT_KEY_EXCHANGE
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
SERVER_KEY_EXCHANGE of 329 bytes
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_handshake:2443 New state TLS_H=
ANDSHAKE_WAIT_HELLO_DONE
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_ecdhe_server_key_xchg:506 Nego=
tiated secp256r1
May 24 12:04:36 jv iwd[781]: TLS: tls_rsa_verify:213 Peer signature verified
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_ecdhe_server_key_xchg:560 New =
state TLS_HANDSHAKE_WAIT_HELLO_DONE
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
CERTIFICATE_REQUEST of 112 bytes
May 24 12:04:36 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
SERVER_HELLO_DONE of 0 bytes
May 24 12:04:36 jv iwd[781]: TLS: tls_tx_handshake:890 Sending a TLS_CERTIF=
ICATE of 1173 bytes
May 24 12:04:36 jv iwd[781]: TLS: tls_tx_handshake:890 Sending a TLS_CLIENT=
_KEY_EXCHANGE of 66 bytes
May 24 12:04:37 jv iwd[781]: TLS: tls_tx_handshake:890 Sending a TLS_CERTIF=
ICATE_VERIFY of 260 bytes
May 24 12:04:37 jv iwd[781]: TLS: tls_tx_handshake:890 Sending a TLS_FINISH=
ED of 12 bytes
May 24 12:04:37 jv iwd[781]: TLS: tls_handle_server_hello_done:2155 New sta=
te TLS_HANDSHAKE_WAIT_CHANGE_CIPHER_SPEC
May 24 12:04:37 jv iwd[781]: TLS: tls_handle_message:2709 New state TLS_HAN=
DSHAKE_WAIT_FINISHED
May 24 12:04:37 jv iwd[781]: TLS: tls_handle_handshake:2354 Handling a TLS_=
FINISHED of 12 bytes
May 24 12:04:37 jv iwd[781]: TLS: tls_reset_handshake:204 New state TLS_HAN=
DSHAKE_WAIT_START
May 24 12:04:37 jv iwd[781]: TLS: tls_finished:2340 New state TLS_HANDSHAKE=
_DONE
May 24 12:04:37 jv iwd[781]: EAP completed with eapSuccess
May 24 12:04:37 jv iwd[781]: TLS: tls_reset_handshake:204 New state TLS_HAN=
DSHAKE_WAIT_START
May 24 12:04:38 jv iwd[781]: netconfig: Failed to start DHCPv6 client for i=
nterface 5


Here follows my profile config

JV.8021x:
[Security]
EAP-Method=3DTLS
EAP-Identity=3Djv
EAP-TLS-CACert=3D/etc/ca-certificates/trust-source/anchors/VYBIHAL-CA.crt
EAP-TLS-ServerDomainMask=3D*.vybihal.cz;*.jvi.cz

EAP-TLS-ClientCert=3Dembed:pepa-VYBIHAL-CA_client_cert
EAP-TLS-ClientKey=3Dembed:pepa-VYBIHAL-CA_client_key

[Settings]
AutoConnect=3Dtrue

[@pem(a)pepa-VYBIHAL-CA_client_cert]
-----BEGIN CERTIFICATE-----
MIIEizCCAnOgAwIBAgIIdF0KMgHJlTIwDQYJKoZIhvcNAQELBQAwNjETMBEGA1UE
AxMKVllCSUhBTCBDQTEfMB0GCSqGSIb3DQEJARYQam9zZWZAdnliaWhhbC5jejAe
Fw0yMjAzMjcxMjQ1MDBaFw0yNzAzMjcxMjQ1MDBaMDAxDTALBgNVBAMTBHBlcGEx
HzAdBgkqhkiG9w0BCQEWEGpvc2VmQHZ5YmloYWwuY3owggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDAn+iMsh5HbrrnmJ8kzrghccos69jRPI8aI/RLlJBm
TFyjakaVPq3GbuKrKDZBc/vT0xfGVbXQrDniB5mouyi/u+q2nOkmKnxDcr64XXXP
RhEL6gPKzdg8QXiEeVMl61osG2JoOc3inEbGE+uAs/r/XfhrpQ8yT1qjuu9mlH5F
m+Igc/kGjQsDrnvX63RHaHzdN1WIRY4MQJV2Y7+q+9B60+IEdnpBa8ITMDdqYHmG
1ecrv91wQfCNDm8NCPjiwxoRJxlZ+8clvjQ4gTm6oVCjNIhofh4X7JmB4H+UmBrG
FGggJdiHfceEM579FWdbqFy6YVRnCtf+7uPaVv+QsBcrAgMBAAGjgaIwgZ8wDAYD
VR0TAQH/BAIwADAdBgNVHQ4EFgQUOKirC47tSr4uKumXhZuEVnK4bygwCwYDVR0P
BAQDAgO4MBMGA1UdJQQMMAoGCCsGAQUFBwMCMBsGA1UdEQQUMBKBEGpvc2VmQHZ5
YmloYWwuY3owEQYJYIZIAYb4QgEBBAQDAgWgMB4GCWCGSAGG+EIBDQQRFg94Y2Eg
Y2VydGlmaWNhdGUwDQYJKoZIhvcNAQELBQADggIBAHMSGs8vpl1aZoVAPBWfEWBT
JyVtpO+Kexbpol47UQJZunws3e0NJcF6Zu39K09InilhS31ZHWjmzJLx/+Dc+FFM
Y3FHI6lY7kuukPxAMo1lm7a0NZ7R6jxlCTacvkEcGwCGLKzw0lvDICUTqS04S/0/
mPnk94xKJ0Lua1nPwY/MOiuyYVCVeF6QRQqI18EgGDlHLAmW/I9S6mmbvo1U2vak
xNS/G3lNaeeCmT6oQJLlMS9/cNCgz6SM432eG478thiGYeo9UNeGGCqaxuFKwASc
YYBidFDlgfJ89+DLBimqDesf0ZF6GxOJ4H6Rf05MzsXWqymp71MWnTKMHFWFRQHH
VJN2rbRZySTuRJQ+Dp1zJUOOxSjFiFtQMoU+lTnlX7uVcqitaEsSr05ACKfn2LVw
ryv4hR+7kvr6/SSJheVnVwcgC752eS9W/95MGcxITN37XsVeifQ8CWSXUPJqYbNp
ooR5xY4xipnumHA/aOpRaitdnRBUvcunX1i5r+E+HvdCTVZmEhnuLoAYUy6MZhYk
gzNLrJAWP3emIC0dATmxzNLaioKd4xZnFuLcMsE33/y9SYuwW3ePbyOqWkBRrnFW
yqBwVmzeg79q+OO4dSYVtW6akDeslicQekoxKNzKu9tz509knacLcgtDYZ2Mivb0
2vfVdPUcVAWv9llNe3Fq
-----END CERTIFICATE-----

[@pem(a)pepa-VYBIHAL-CA_client_key]
-----BEGIN RSA PRIVATE KEY-----
 redacted
-----END RSA PRIVATE KEY-----


I also manage the radius server, the bad auth is seen there, but the
error is not helpful:

ERROR: (20339) eap_tls: ERROR: TLS Alert write:fatal:handshake failure
Error: tls: TLS_accept: Error in error


Other clients (wpa supplicant on other laptop, android phone, windows)
does not have this problem. Only this laptop using iwd is acting this
way :(

Any idea what could be going on here?

Josef



--===============0749310720587120034==--

