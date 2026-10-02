Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202E3E5A17
	for <iwd@lists.linux.dev>; Fri,  2 Oct 2026 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933745; cv=none; b=fXrLNiuA/6EeL45TxEd8gmPCQ6zp/ZY8XNOfdDI7YrjpqKzYNtQ6mnt75nKsdfWeknynINtw814dsVtJEhqdietXUDYOzBJ4kuXiNFCmgn5op43Ula994VYdxiA0D0eZrJC5uTRdciLX41893sjE9WTECrwwCQDGCXyXVvl73mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933745; c=relaxed/simple;
	bh=0WLScvmjLXtP68MrDhpnqxOojA0P7gEZ9Ng36vHq2xo=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=jylK3lwS/+pSehaBgZFVMTwiuwUOZiMysGqWNbfAwgoArifGgI+TBPa3/wLH6ptZEX+ZoXgy05+CBOO53q0o616W37MP71nvqBU/PzTv/7e2AsKPRiHUEfc24JKfAMhswwAQ8fjI/zUpiokRD13vtbGF1no4vV9QNQ4ueQUqWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=U4pR3pq8; arc=none smtp.client-ip=79.135.106.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="U4pR3pq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1790933739; x=1791192939;
	bh=0WLScvmjLXtP68MrDhpnqxOojA0P7gEZ9Ng36vHq2xo=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=U4pR3pq8qQOxHhAmi0h9oSxg+ym1vnfH0WEIZKoD4kxKQqLSl9CQLX26vuLwrZDmh
	 1UQsVGYoRpJKRB/UZC0APFCrgw7aRTGvc0kRPVmuD72nkoAzQoUAGVpvhTm49esWAY
	 OfZddx4FS4wRLZvajdAQm6n8CpAdushOjEpnSNzUggyWGur0eOnI8TOqIWssLejb0R
	 FzcfqJxjIoDZczxj5yG+tiYJJ9EnC0A2KRwkUfVKuwauzFfkub8sHB+MkzR4Mu4lKr
	 +w/pyIkD7eL83bZ9+4nDjwkG1IsHRqN8Hz1y+Pm3RrKu5NeihPC1FD4MACieJ6jaHE
	 cZkxcX1DqK3lQ==
Date: Fri, 02 Oct 2026 09:35:36 +0000
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: lasushin <lasushin@proton.me>
Subject: [BUG] SIGSEGV in l_tls_start during preauthentication (PEAP, NULL peer id), iwd 3.12
Message-ID: <SBQ2JJPQcKfMWu8g-_Gatj20vRXehDn0UFAlgVnWDh5TGh96UiAhfFISij-Dja4-diJiJoWYDEwbVm25pZ23UpsxgMSyKoInKCODXbj5u2Y=@proton.me>
Feedback-ID: 125561375:user:proton
X-Pm-Message-ID: 1b016c8833207931d33e03ca61301c52aa06da19
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
iwd 3.12 with ell 0.83 (Arch Linux, x86_64) segfaults when it starts
preauthentication to a roam target on an 802.1X network using PEAP.
I have hit it twice on eduroam (PEAP/MSCHAPv2), both times right after
a roam scan picked a new BSS:

=C2=A0 event: state, old: connecting, new: connected
=C2=A0 event: roam-scan,
=C2=A0 event: roam-info, bss: 80:80:2c:c5:b1:40, signal: -81, load: 44/255
=C2=A0 iwd.service: Main process exited, code=3Ddumped, status=3D11/SEGV

Backtrace from the core dump:

=C2=A0 #0 =C2=A0__strcmp_avx2 ()
=C2=A0 #1 =C2=A0group_match (a=3D..., b=3D...) at ell/settings.c:772
=C2=A0 #2 =C2=A0l_queue_find (queue=3D..., function=3Dgroup_match, user_dat=
a=3D0x0)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 at ell/queue.c:332
=C2=A0 #3 =C2=A0l_settings_has_key (settings=3D..., group_name=3D...,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key=3D"SessionID") at ell/settings.c:866
=C2=A0 #4 =C2=A0tls_load_cached_client_session (tls=3D...) at ell/tls.c:101=
2
=C2=A0 #5 =C2=A0l_tls_start (tls=3D...) at ell/tls.c:3600
=C2=A0 #6 =C2=A0eap_tls_tunnel_init (eap=3D...) at src/eap-tls-common.c:708
=C2=A0 #7 =C2=A0eap_tls_common_handle_request (...) at src/eap-tls-common.c=
:815
=C2=A0 #8 =C2=A0__eap_handle_request (...) at src/eap.c:329
=C2=A0 #9 =C2=A0__eapol_rx_packet (...) at src/eapol.c:3140
=C2=A0 #10 netdev_control_port_frame_event (...) at src/netdev.c:5660
=C2=A0 #11 netdev_unicast_notify (...) at src/netdev.c:5751

The eap_state in frame 6 belongs to a preauth_sm (its callbacks are
preauth_eap_msg_cb / preauth_eap_results_cb / preauth_eap_complete_cb)
and has peer_id =3D NULL. In ell, tls->session_prefix is NULL and
group_name in tls_load_cached_client_session() is NULL.

As far as I can tell the cause is that eapol_preauth_start() creates
the EAP state without calling eap_set_peer_id(), unlike eapol_start()
which sets it to the hex SSID. eap_tls_tunnel_init() then passes
eap_get_peer_id(eap) =3D=3D NULL as the group prefix to
l_tls_set_session_cache(), and l_tls_start() ends up calling strcmp()
on a NULL group name.

The change below mirrors what eapol_start() does. I have not=C2=A0
tested it.

diff --git a/src/eapol.c b/src/eapol.c
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -3074,6 +3074,7 @@ struct preauth_sm *eapol_preauth_start(const uint8_t =
*aa,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eapol_preaut=
h_destroy_func_t destroy)
=C2=A0{
=C2=A0 =C2=A0 =C2=A0 struct preauth_sm *sm;
+ =C2=A0 =C2=A0 _auto_(l_free) char *network_id =3D NULL;

=C2=A0 =C2=A0 =C2=A0 sm =3D l_new(struct preauth_sm, 1);

@@ -3093,6 +3094,9 @@ struct preauth_sm *eapol_preauth_start(const uint8_t =
*aa,

=C2=A0 =C2=A0 =C2=A0 eap_set_key_material_func(sm->eap, preauth_eap_results=
_cb);

+ =C2=A0 =C2=A0 network_id =3D l_util_hexstring(hs->ssid, hs->ssid_len);
+ =C2=A0 =C2=A0 eap_set_peer_id(sm->eap, network_id);
+
=C2=A0 =C2=A0 =C2=A0 sm->timeout =3D l_timeout_create(EAPOL_TIMEOUT_SEC, pr=
eauth_timeout,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sm, NULL);

iwd is used as the NetworkManager Wi-Fi backend.

Thanks,
Lasu Shin
