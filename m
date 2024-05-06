Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E515572C
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715022687; cv=none; b=gEhKQsF270m2dKBdjiZUiB71gyTemWmlaPvMP1FRYC5L59xOPpMCDPTg5IAwPV07tdr9vyzz1Ywfa4VrRT+oCG/0EnhIFt/UvCmodRfFxAIVgfBfbaU2EUzA5weVgdDrx8mLx2+ROSdOe2Vew1MHCzOsJH8Czde33pY5qvstZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715022687; c=relaxed/simple;
	bh=r0tDtLMJu93+EE1OcZQ9mru0cq1bcXRwEYS7hCc9Kgo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q1goKGR9zbd2qKnIXLOWrxsglxU4kFN05+xwjyXVgS61Ciq+fZZJr08fkl7+QSpMb676lVonU9Wyj5dfeP2bIIm5BkYUl9xBLCjmHFtleh1R8rWem6aXDsyuTyxssOWjKxWyu6HJWiz520XXMXmW8vWzzwU+4H4fxkTFwoHMuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTu6on1o; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTu6on1o"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-434d0e3f213so6111581cf.3
        for <iwd@lists.linux.dev>; Mon, 06 May 2024 12:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715022685; x=1715627485; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r6jQ3QCB9U7SMkRr/QF2xwf4hfWRdg0uoVLGfZUtv+8=;
        b=fTu6on1oN3YZ0WmUlGm66h4MjQDfDeNWT6248o/3IluZ8BXmAHeaHz9iq2dJS2/Vzl
         dfLxqitsKtbtlRY9ensHF+wnpvVWup4Zb3PxrxmkqogvCx4NCrDkO93RpuIzDLyGdZtj
         RwBpcaQ9qsLaLQs4x35p+z1n3czT4gzOsELwj60lRpcDfvoxkRwx5HUigQoXLnfhyFog
         hzFeucjBZVvV68404FVQQvCk8cBZW3AtLsDtNBiICbo02jvStVqeAWbzWKM4MrFH5C/z
         hl1L3RTzRvI/+ljQkzUvIwl8pXxdIAfmg3fpzRfboYQCKS15HaYwdUYEx1sLxUoQeGXe
         tUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715022685; x=1715627485;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6jQ3QCB9U7SMkRr/QF2xwf4hfWRdg0uoVLGfZUtv+8=;
        b=EKFd7Q/SnPLzS5z69YNpWb1VEZ0HEbU0ypBl1lYh7OeJDQxv3iejn20I3BD6FIocqE
         74m2qgZwuQ21GOKbUAK619sdv3CopukWDAO/LV1NVBLxIz+9ZLmlAdtDJfdSJWDIV6Ne
         gCOsQZZ0HVtScchWzm6MH91YmjDVndvMXQ5vVeG/9ivEwaehJwREnFWq5quIPz1jhl9h
         HlT+/idwqfji0Xzw3EyopDPPkws5h4N7GkxLy2BDdtlL7gUSohjeEOJ0x5r7dvnIT4wy
         Ya2Hgu0CcUzkvhHuXAgyof96Gn3HXWIuSNXaxd+QmCa0DuJei7ZCMtzLjHP4MKwttFDI
         izrA==
X-Gm-Message-State: AOJu0YzNK/ldczRRydH+T7+Cx6YC1CLf7p4yw4W5TCTvmxsgaC22neU8
	jIUDLfDOp+UlUit2caydsKcAEtD0lsEhAk/qKAXdGCrtM2zL2nyXb8CiFtQl7EaRkrI8x4DcJbx
	OqINPspXioKWZCtFzT+6S+PXvSVKVF4k/
X-Google-Smtp-Source: AGHT+IEby7rAtjYj4uf4gX24hOsiQaNxAkOqVzrlWWAryk3GecZB8x6jw7UgKbzgazR7nFkkJG2V9GCPeCgH404kslg=
X-Received: by 2002:ac8:5981:0:b0:43a:b2c9:60e7 with SMTP id
 e1-20020ac85981000000b0043ab2c960e7mr12775663qte.35.1715022684815; Mon, 06
 May 2024 12:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 6 May 2024 13:11:13 -0600
Message-ID: <CADvTj4qmJm_Lyk5bR_WZE8TioVa5f0MHdtDghJdRX=9ZhivzjA@mail.gmail.com>
Subject: NetworkManager connection gets stuck in pending state when bringing
 up AP mode connection with IWD backend
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

It's a bit unclear if this is a NetworkManager bug or an IWD bug but
I'm unable to successfully bring up AP mode connection in
NetworkManager when using the IWD backend.

It appears that NetworkManager fails to recognize that IWD has brought
up the AP successfully for some reason even though the AP is
active(i.e. devices can connect to the AP). This results in
NetworkManager failing to appropriately configure the routes needed
for the AP.

Logs from NetworkManager:
<debug> [1709938743.1640] device[e4bcd76bde98e8a1] (wlan0):
Activation: (wifi) Called Start('APSSID').
<debug> [1709938743.1641] device[e4bcd76bde98e8a1] (wlan0):
Activation: (wifi) IWD Device.Mode set successfully
<debug> [1709938743.1644] device[e4bcd76bde98e8a1] (wlan0):
remove_pending_action (1): 'recheck-available'
<trace> [1709938743.2594] platform: (wlan0) emit signal
ip4-address-changed added: 192.168.45.129/28 brd 0.0.0.0 lft forever
pref forever lifetime 1235-0[4294967295,4294967295] dev 5 flags
permanent src kernel
<debug> [1709938743.2595] platform: (wlan0) signal: address 4   added:
192.168.45.129/28 brd 0.0.0.0 lft forever pref forever lifetime
1235-0[4294967295,4294967295] dev 5 flags permanent src kernel
<trace> [1709938743.2598] platform: (wlan0) emit signal
ip4-route-changed added: type local table 255 192.168.45.129/32 dev 5
metric 0 mss 0 rt-src rt-kernel scope host pref-src 192.168.45.129
<debug> [1709938743.2599] platform: (wlan0) signal: route   4   added:
type local table 255 192.168.45.129/32 dev 5 metric 0 mss 0 rt-src
rt-kernel scope host pref-src 192.168.45.129
<trace> [1709938743.2602] platform: (wlan0) emit signal
ip4-route-changed added: type unicast 192.168.45.128/28 dev 5 metric 0
mss 0 rt-src rt-kernel rtm_flags linkdown scope link pref-src
192.168.45.129
<debug> [1709938743.2602] platform: (wlan0) signal: route   4   added:
type unicast 192.168.45.128/28 dev 5 metric 0 mss 0 rt-src rt-kernel
rtm_flags linkdown scope link pref-src 192.168.45.129
<trace> [1709938743.2609] platform: (wlan0) emit signal link-changed
changed: 5: wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup>
mtu 1500 arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03
permaddr BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae
tx-queue-len 1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size
65536 rx:443,42144 tx:563,224232
<debug> [1709938743.2610] platform: (wlan0) signal: link changed: 5:
wlan0 <UP,LOWER_UP;broadcast,multicast,up,running,lowerup> mtu 1500
arp 1 wifi? init addrgenmode none addr BC:25:F0:1D:6A:03 permaddr
BC:25:F0:1D:6A:03 brd FF:FF:FF:FF:FF:FF driver rtl8821ae tx-queue-len
1000 gso-max-size 65536 gso-max-segs 65535 gro-max-size 65536
rx:443,42144 tx:563,224232
<debug> [1709938743.2611] device[e4bcd76bde98e8a1] (wlan0): queued
link change for ifindex 5
<info>  [1709938743.2657] device (wlan0): Activation: (wifi) Stage 2
of 5 (Device Configure) successful.  Started 'APSSID'.
<debug> [1709938743.2658] device[e4bcd76bde98e8a1] (wlan0):
activation-stage: schedule activate_stage3_ip_config
<debug> [1709938743.2659] device[e4bcd76bde98e8a1] (wlan0):
activation-stage: invoke activate_stage3_ip_config
<debug> [1709938743.2660] device[e4bcd76bde98e8a1] (wlan0):
activation-stage: synchronously invoke activate_stage3_ip_config
<debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip4:
required-timeout: disabled
<debug> [1709938743.2661] device[e4bcd76bde98e8a1] (wlan0): ip6:
required-timeout: disabled
<debug> [1709938743.2662] active-connection[c8d123b3d4d3f96d]: set
state-flags layer2-ready (was none)
<info>  [1709938743.2664] device (wlan0): state change: config ->
ip-config (reason 'none', sys-iface-state: 'managed')
<debug> [1709938743.2699] device[e4bcd76bde98e8a1] (wlan0):
add_pending_action (2): 'in-state-change'
<debug> [1709938743.2704] device[e4bcd76bde98e8a1] (wlan0):
remove_pending_action (1): 'in-state-change'
<info>  [1709938743.2709] device (wlan0): IWD AP/AdHoc state is now Started
<trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip4:
check-state: state pending => pending, is_failed=0, is_pending=0,
is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
<trace> [1709938743.2710] device[e4bcd76bde98e8a1] (wlan0): ip:
check-state: (combined) state pending => pending
<trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip6:
check-state: state pending => pending, is_failed=0, is_pending=0,
is_started=0 temp_na=0, may-fail-4=1, may-fail-6=1;;;
<trace> [1709938743.2711] device[e4bcd76bde98e8a1] (wlan0): ip:
check-state: (combined) state pending => pending

NetworkManager bug report with some more details:
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1498
