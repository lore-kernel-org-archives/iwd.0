Content-Type: multipart/mixed; boundary="===============7630348261964363939=="
MIME-Version: 1.0
From: Alexander Monakov <amonakov@ispras.ru>
Subject: Thoughts from recent troubleshooting session
Date: Sat, 01 May 2021 01:34:28 +0300
Message-ID: <alpine.LNX.2.20.13.2105010038000.28416@monopod.intra.ispras.ru>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7630348261964363939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

Three days ago I popped in the IRC while investigating why IWD wouldn't
connect to my org's WiFi with settings I ported from wpa_supplicant's
config. We managed to narrow down the issue to kernel crypto lib failing
to validate the leaf certificate given by the AP against the CA cert
(the leaf is missing the AKID).

Troubleshooting experience seems to be very hit and miss for new users
as I'll attempt to explain below.

dmesg was telling me that iwd was associating to the AP, and then one
second later disassociating with reason 23=3DIEEE8021X_FAILED.

I tried running 'iwd -d' and 'IWD_TLS_DEBUG=3D1 iwd -d'. The first
unwelcome surprise was that there was almost zero difference in the
logs, so I had to spend a few cycles checking if I typo'ed IWD_TLS_DEBUG
vs. IWD_DEBUG_TLS or whatever.

From perusing mailing list archives I got the idea to try filling
EAP-Identity.  This indeed got me to the TLS phase and I got dumped
certificates in /tmp.

Apparently, all other tools implicitly pick up configured inner identity
as the outer identity if the latter is not specified (and indeed I did
not need to specify it in wpa_supplicant Linux config, or on my phone).
The documentation is not doing a good job of explaining the situation:
it says EAP-Identity might be needed depending on RADIUS server, but it
doesn't help me realize that *even if* I did not have to specify it for
other tools, I may need to copy-paste it explicitly for IWD.

Another thing I want to highlight here is that debug spew from 'iwd -d'
seems really unstructured and it's difficult to see which phases were
completed successfully, and where things have gone off the rails.

I see a recent commit improved the situation a bit by hinting about
EAP-Identity specifically.


With dumped certificates in /tmp I could see that the AP is presenting
the expected root certificate, and 'openssl verify' successfully
validates the leaf.  I spent a bit more time looking up the
certchain_verify tool in libell and figuring how to feed it PEM
certificates (this also seems improved with a recent commit, thanks!),
which narrowed down the problem to the kernel failing to validate our
certificate chain.

Thanks to another recent commit I can successfully connect with IWD if I
do not provide the CA cert in the config, but that is an undesirable
workaround.

Happy hacking.
Alexander
--===============7630348261964363939==--

