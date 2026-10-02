Received: from mail-24429.protonmail.ch (mail-24429.protonmail.ch [109.224.244.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829F47A88B
	for <iwd@lists.linux.dev>; Fri,  2 Oct 2026 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935028; cv=none; b=H3SeGJk+iwcNkFm6jkvnkrXgwznniBhHnttYfKqIGx1IV0kOR1I5E8bkbJ0O7yJZGL1dVeOGPWZLGETDsU4fgeTREfas+BI4k++YOD4spVCq2zwt7SzWdONhaUaXqAYZ6e4980ENBa5wEiDBSW/Ijkvcnd592opE2XuQtuVTVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935028; c=relaxed/simple;
	bh=fEtiIlkq5hsRjWSXY32pVMXvcMIZmq0g757pO73H/Rg=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=rsTknu314Qsrc6Pzj13dYSPcg1siivRUm/oSJ6qx9FZJNXJhUrKGKxRO71RjggjjORmTvEAgDBjMzMs3o7Wxv1Fh0XLoBO2UB3IwNCnEttdcPFEHPPj+7iL1ismdkZOW9bejehLUSMkJyaUFr2IPw1YMFpPUedhKcIrSHEBiXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=sZj+gLzJ; arc=none smtp.client-ip=109.224.244.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="sZj+gLzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1790935013; x=1791194213;
	bh=lyDEyT9SieZJ+YrDCnzIcWqiktH+DPbXpV3YOMsKWGA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sZj+gLzJe+dZUbY7SVEbEN9PCEHqZviauVeBxAVR+Zg2AMSUM5SdjAUufjs9OVbBm
	 M+FtYpnCCYkErj/b9fzvwdvxRiweHddw4yRrK4YKGK/1MP5Z6Tgd9dCAI6QaDHXtEn
	 hFawJGJ+cW253kmooKJn8M4cBlfIMqsKsWxaJPb+CcLFYhXkhcl4s+UIPF7cR6UkM1
	 1yc2xQvcVk8VRassaGxh4r15ta+sycYlSVzL2CObQ6nEfGGKhF8TWu5Eidf6mju0Tl
	 p5Pm83zWTrJeATWJw6+l8WleVIV5ntqXs8Oe1t2OMMePLnC9fl5e+1qDOiYyGCT3+R
	 J1t/w+1Mot8Mw==
Date: Fri, 02 Oct 2026 09:56:48 +0000
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: lasushin <lasushin@proton.me>
Subject: [BUG] SIGSEGV in l_tls_start during preauthentication (PEAP, NULL peer id), iwd 3.12
Message-ID: <883wP6hFpFxz8FjR1WI25BU1FOjlOiRKQ7BIMzizSlCcMYNn6aptkmkddmJoKpwtR8QwxpIHFS3154DfcO-z7QrmMhOx4h6UaCQOpnXm9dA=@proton.me>
Feedback-ID: 125561375:user:proton
X-Pm-Message-ID: 2d75e470dac86945d66ebb142b8f6a6f8ab47b97
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

  event: state, old: connecting, new: connected
  event: roam-scan,
  event: roam-info, bss: 80:80:2c:c5:b1:40, signal: -81, load: 44/255
  iwd.service: Main process exited, code=3Ddumped, status=3D11/SEGV

Backtrace from the core dump:

  #0  __strcmp_avx2 ()
  #1  group_match (a=3D..., b=3D...) at ell/settings.c:772
  #2  l_queue_find (queue=3D..., function=3Dgroup_match, user_data=3D0x0)
          at ell/queue.c:332
  #3  l_settings_has_key (settings=3D..., group_name=3D...,
          key=3D"SessionID") at ell/settings.c:866
  #4  tls_load_cached_client_session (tls=3D...) at ell/tls.c:1012
  #5  l_tls_start (tls=3D...) at ell/tls.c:3600
  #6  eap_tls_tunnel_init (eap=3D...) at src/eap-tls-common.c:708
  #7  eap_tls_common_handle_request (...) at src/eap-tls-common.c:815
  #8  __eap_handle_request (...) at src/eap.c:329
  #9  __eapol_rx_packet (...) at src/eapol.c:3140
  #10 netdev_control_port_frame_event (...) at src/netdev.c:5660
  #11 netdev_unicast_notify (...) at src/netdev.c:5751

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

The change below mirrors what eapol_start() does. I have not=20
tested it.

diff --git a/src/eapol.c b/src/eapol.c
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -3074,6 +3074,7 @@ struct preauth_sm *eapol_preauth_start(const uint8_t =
*aa,
                                      eapol_preauth_destroy_func_t destroy)
 {
      struct preauth_sm *sm;
+     _auto_(l_free) char *network_id =3D NULL;

      sm =3D l_new(struct preauth_sm, 1);

@@ -3093,6 +3094,9 @@ struct preauth_sm *eapol_preauth_start(const uint8_t =
*aa,

      eap_set_key_material_func(sm->eap, preauth_eap_results_cb);

+     network_id =3D l_util_hexstring(hs->ssid, hs->ssid_len);
+     eap_set_peer_id(sm->eap, network_id);
+
      sm->timeout =3D l_timeout_create(EAPOL_TIMEOUT_SEC, preauth_timeout,
                                      sm, NULL);

iwd is used as the NetworkManager Wi-Fi backend.

Thanks,
Lasu Shin
