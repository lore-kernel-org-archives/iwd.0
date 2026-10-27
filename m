Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112428;
	b=L9BzGFsp4/h1cRNmS2xZOSKOpfRDWS735THlmXkwHLyyArWv+7G4O6rOP22p4mavb0ak
	 BdajfjnhFV1Xb6VmAQzhCfiFJ5qvLgctG5Ts0Etva4klzmFH0JlLRGSJe+PKCl2bjy2zZ
	 Y0SrgK8HW9mc/bkkBOFhbi5ofLLyB8zE1HDj6kVaj65R1IT9QMeyoHt5jjeYb1V76l+VA
	 jQjur/ThpQoVzWdpQ6O0/aEqK5JBQhSCgsFxohFgvTsGcTBxvjo7OMoV/XDoUXneFVVKL
	 OK9jz7p3iYiC4c5/y4HbRn3NzEBl5waf4F0h/U1w0u1l4A1M9QXGb78kA2WrdqPqsFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112428;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MR/cWII7SUw+GDeHhO6xiKH3Z8/h1PceUbVKc5VKRy8=;
	b=pBAa8DuGtf9Wo+f0LKn574ZtWdFc7E6dyWUZqwCe8jmnG9c2hZGSJrJ0THM4htgFNLwA
	 1Lo6Y1Nv151D45ssXEYjoPe+petW4WUU5iQUWa4c+Pq7zXA7dhdVA3uqSvNJLdIeNKzEk
	 n/uzNohVHw76J/v8k9qLbwEouAj75kXVOosT/5WomLC/tkycO1cxiZJRJ9ix05KA0Y9h4
	 Vq2I3Ta0hvdY7AYGDiCpFbfzewUJsmE05uBSFFlCuTIe9qLQW4g6NNLYvmo+pmH+sGBtP
	 0iLDYQQmsT7+8o4mch3T8i0ehlvD6G3CYVVLWhcQJ7obxhX9kV1Qk3/6W1MYfgtMCHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wiesner.com.br;
	spf=fail smtp.mailfrom=wiesner.com.br;
	dkim=pass header.d=wiesner.com.br header.i=@wiesner.com.br header.a=rsa-sha256 header.s=protonmail3 header.b=bWM+gQ2W;
	arc=none smtp.remote-ip=79.135.106.116
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301C606A31A
	for <iwd@lists.linux.dev>; Tue, 27 Oct 2026 14:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A301C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiesner.com.br
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=wiesner.com.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wiesner.com.br header.i=@wiesner.com.br header.a=rsa-sha256 header.s=protonmail3 header.b=bWM+gQ2W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesner.com.br;
	s=protonmail3; t=1793112424; x=1793371624;
	bh=MR/cWII7SUw+GDeHhO6xiKH3Z8/h1PceUbVKc5VKRy8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bWM+gQ2WnqzoGsCVbi8YK4fzjQ/FFoy8V8EEbayUqRpHm8I3q9K/V+hIONp56UVE9
	 cmtXC+L9f2rhIHKPnE6RzTw8tpw0Yx/igPpEFjvtvq1LgFtrP+yC8sStScbJUH356t
	 Jfpv52IZe6AoZMPc9iUS39GPf3BAY9ugnxJdwNDg6uJQHRw8wbgdE9gz59LLTEL/rS
	 biJ9/ZvdrMzkz7GbRxxu6mph+ttyCJIZDwp/jt2rNM+SyOE9Dc7lVHxFSg/lr5IQZk
	 1eO5bsYtF3B65fEKho1PAo4f5Z3v9f1mfA+r4ulTOtWfPrQzMH6Lx1JITLf28gi9x8
	 oxWIDU/YaqG7Q==
Date: Tue, 27 Oct 2026 14:47:01 +0000
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Misc <misc@wiesner.com.br>
Subject: eap-peap: fix phase 2 abort on MSCHAPv2 challenge
Message-ID: <HsrMm4wWopIj8Xhva2FSiGWA-ZSErQQeeagi9cx-ZOeP_Qh7q5WQlbXNMHD4i2asnWbEeBiqqWWIApGBTh8MNX5MaNmqqI3Sk71oDYBk09E=@wiesner.com.br>
Feedback-ID: 148803267:user:proton
X-Pm-Message-ID: cd1b2e4cc2b6392aced2168e1a9a7668403795f4
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Post: <mailto:iwd@lists.linux.dev>
List-Help: <mailto:iwd+help@lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iwd+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
I'd like to report a bug in EAP-PEAP that makes iwd unable to=C2=A0authenti=
cate on my university's eduroam network. First, a note on=C2=A0provenance: =
the debugging, root-cause analysis and the proposed patch=C2=A0below were p=
roduced with the help of an AI coding assistant working on=C2=A0my behalf. =
I directed the investigation and can attest that the=C2=A0evidence quoted b=
elow is genuine and that the fix works on the real=C2=A0network as describe=
d, but I don't have the C/wireless expertise to=C2=A0independently review t=
he code change, so I'm submitting this as a bug=C2=A0report with a proposed=
 patch rather than a formal contribution. I'm happy to run=C2=A0further tes=
ts or collect additional traces on this network if useful.

-- The bug --

On eduroam networks whose RADIUS server negotiates PEAP version 0 with EAP-=
MSCHAPv2 as the phase 2 method (observed with Cisco ISE at the University o=
f Warwick), iwd never completes authentication: the TLS tunnel is closed wi=
th a close_notify alert right after the tunneled identity exchange, the AP =
deauths with reason 23 (802.1X authentication failed) and the log prints th=
e (misleading) diagnostic:

=C2=A0 =C2=A0 PEAP: Tunnel has disconnected with alert: close_notify
=C2=A0 =C2=A0 Received Deauthentication event, reason: 23, from_ap: true
=C2=A0 =C2=A0 EAP negotiation stopped after the Identity exchange, this can
=C2=A0 =C2=A0 happen when the EAP-PEAP-Phase2-Identity value is not what th=
e
=C2=A0 =C2=A0 authenticator expects

The same network and credentials authenticate fine with wpa_supplicant 2.12=
, which is what makes this look like a credentials/identity problem and, I =
suspect, why it is easy to misdiagnose.

-- Root cause --

eap_peap_tunnel_handle_request() detects the EAP-Extensions (result TLV) pa=
ckets - which arrive with a full EAP header even in PEAPv0 mode - by checki=
ng only pkt[4] =3D=3D EAP_TYPE_EXTENSIONS before the version dispatch:

=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len > 4 && pkt[4] =3D=3D EAP_TYPE_EXTENSION=
S) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t code =3D pk=
t[0];
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (code !=3D EAP_C=
ODE_REQUEST)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return false;

In PEAPv0 the tunneled phase 2 data is headerless, so byte 4 belongs to the=
 inner method's data, not to an EAP header. =C2=A0An EAP-MSCHAPv2 challenge=
 carries MSCHAPOpCode 0x0021 (Challenge), placing 0x21 - which equals EAP_T=
YPE_EXTENSIONS (33) - at byte 4. =C2=A0Every tunneled MSCHAPv2 challenge is=
 therefore misclassified as an Extensions packet; the code check then fails=
 (0x1a is the EAP-MSCHAPv2 type, not EAP_CODE_REQUEST) and the function ret=
urns false, which makes eap-tls-common close the tunnel. =C2=A0The challeng=
e never reaches the phase 2 state machine, which is why the log blames the =
identity exchange.

An iwmon capture of the failing exchange (iwd 3.12) and a wpa_supplicant -d=
d reference trace of a successful one show the exact same server behaviour =
up to the point of the failure:

=C2=A0 - tunneled EAP-Request/Identity, 1 byte of headerless data (0x01)
=C2=A0 - client responds, 23 bytes of headerless data (0x01 || identity)
=C2=A0 - server sends the MSCHAPv2 challenge, 34 bytes of headerless data
=C2=A0 =C2=A0 (1a 01 5b 00 21 ...)

after which wpa_supplicant replies with an MSCHAPv2 response while iwd send=
s a TLS close_notify alert instead.

wpa_supplicant never aborts on such data because its skip_change logic in e=
ap_peap_decrypt() requires hdr->code =3D=3D EAP_CODE_REQUEST together with =
the type check before treating tunneled data as a full EAP packet, and fall=
s through otherwise.

-- Proposed fix --

Only take the EAP-Extensions path when all header fields match (code, lengt=
h consistency); otherwise fall through to the normal version dispatch so he=
aderless phase 2 method data is processed normally.

Verified against the same network: iwd 3.12 with this patch applied authent=
icates immediately and gets an IP, where stock 3.12 fails with reason 23 as=
 described above. =C2=A0(My locally built test binary carries this patch; t=
he iwmon/wpa_supplicant traces are from the same machine, same credentials,=
 same AP.)

=C2=A0src/eap-peap.c | 15 ++++++++-------
=C2=A01 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -507,17 +507,18 @@ static bool eap_peap_tunnel_handle_request(struct eap=
_state *eap,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct peap_state *peap_state;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t id;

- =C2=A0 =C2=A0 =C2=A0 if (len > 4 && pkt[4] =3D=3D EAP_TYPE_EXTENSIONS) {
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t pkt_len;
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t code =3D pkt[0];
-
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (code !=3D EAP_CODE_R=
EQUEST)
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return false;
-
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt_len =3D l_get_be16(p=
kt + 2);
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pkt_len !=3D len)
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return false;
-
+ =C2=A0 =C2=A0 =C2=A0 /*
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* EAP-Extensions (result TLV) packets arrive w=
ith a full EAP
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* header even in PEAPv0 mode. =C2=A0Match all =
header fields before
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* treating tunneled data as Extensions: in PEA=
Pv0 headerless
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* mode byte 4 is part of the inner method data=
, and an
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* EAP-MSCHAPv2 challenge (opcode 0x0021) would=
 otherwise be
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* mistaken for an Extensions packet (type 33 =
=3D=3D 0x21), fail
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0* the code check and needlessly close the tunn=
el.
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
+ =C2=A0 =C2=A0 =C2=A0 if (len > 4 && pkt[4] =3D=3D EAP_TYPE_EXTENSIONS &&
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pkt[0] =3D=3D EAP_CODE_REQUEST &&
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 l_get_be16(pkt + 2) =3D=3D len) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id =3D pkt[1];

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eap_extensions_hand=
le_request(eap, id,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkt +=
 EAP_EXTENSIONS_HEADER_LEN,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=
 EAP_EXTENSIONS_HEADER_LEN);

Thanks for maintaining iwd, and please let me know if any additional traces=
 or tests would help.

Alexander Wiesner
