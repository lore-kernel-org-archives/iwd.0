Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9D181334
	for <iwd@lists.linux.dev>; Sat, 11 Jul 2026 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783800452; cv=pass; b=ipJUDYBUXz04wrX9fXk5kVMWeVeuC068BpMpkX9HAeEqa3h9xbDSU4C1TDjNRYz5wcucBOaWu6k44hHQR2dhKd8/VmGPLMhii4NZ9aNY2tIK9Ffa4joPLtihxp09dQWk8yp5cahFw+vTm/d23e9GYNrDjj2CmWpoFzolvsjp48s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783800452; c=relaxed/simple;
	bh=K/FMPm/vdIC14AewI5GPNth0ykXdBxQJeAgPJVllTMA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NOxUyzQybPbgndBOui2GfIjMuj+n88ACz1UQRqvPUU2p2q4puBujUE8CQTmb6a4IxpjE82nB4wW0H3mdlBjDHSlA4tPus5jnQ1V0yh4fWWUMhAEjiNA+JQjJzv5JQgxmsmM7BCKqSBM/RFXXggE+oAtjxMw1xuI7ysQgfEo+OWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME9G2dpR; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME9G2dpR"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c4436d02cso8912781cf.1
        for <iwd@lists.linux.dev>; Sat, 11 Jul 2026 13:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783800450; cv=none;
        d=google.com; s=arc-20260327;
        b=lXiX3uBdOD9VBwgVXY1MDTwZ/gQGZBtsD4f/Ddo7FHXR0Y8pWoGE1mSgCMOdUNoft1
         GaBNwx7dA5FWSBssvHoefI0DDSOi0B8bgzCYwxPRBImkuOY2Udw85kXDLUnD3p9ks/CV
         Bkofj5fPeZx7y0Ri1u/LhuG29z85xQbhVC8VAS2do0ZQFQ8Le9oO7ARYaGHRoheUiGLF
         NemWTJnWkZT0+GLdAQkzuZB5fW0rSlRFL6K/lYDb244ssAqkN5BfAY2W5uNzs4B35ePq
         6EcVRqg4BBEKW74pEAKYKhdfNzCpR6Ba6PtdzdLfCfpdP4IYu1HjHk+1nBgWHpsQIQmR
         mYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+htTDv5FbsAzj3FUorf5GAcMLrIvoNH3le3blNjkwWo=;
        fh=LVwSdJJT2poHpWJpvI73c3fFqaJVA08Td3ZAiex6+kI=;
        b=NkV2Flb/O6VsuJ2ZTs9MTQNAP89MYIsGW7afWH73wzjsk8HjYoCL7bsl7eVJUO2R6a
         2vnxElBmU8IMB67DE/jGRR+wVGkjCa44LLSDrwHCNFp/a4uWRvjBY8fWpNaGuxxdMWwd
         q2slThw1eAyO7qy/BAbHMBsh1ap2Bb7bckOgbFtVIMIhetH/Nqbv6It0MQyQJUA9vORY
         rQ8yGosqGY12WmW1cXLfPs1FZzkk/Db9Lzlkwtd9P82xqAOyWhJl6h/ZOTXqvSG4XqZt
         nQKKpcn8LSWBp4/0KF945mR+tuPRMO+Es016Ai46wiSkzwrdHPT/ujYLCREaLTmsug0T
         s2gw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783800450; x=1784405250; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+htTDv5FbsAzj3FUorf5GAcMLrIvoNH3le3blNjkwWo=;
        b=ME9G2dpReRE9PzyINawSFYDdeqB4aMDVxnUKdu49mZ+9DXDSNwo2cjC8LkeGI3vBxU
         QqYPLC4dOoix5JoNlRHkGf1Gd1KgWD3U8SNJrOu0uVD/vLiNNruKUhMAJPENFg/P7fqt
         gH7pWVCPQ6xx3Fcq8cDHVAmhgi1w0c/XG+l27ppiB3W1JAggC+T+v+WWzqGS5LG5Rfpx
         9SEE0+KAfZBuOW7eV7wkOv5jGWjyqkJZf0ALtzUP6/UCcuahvUXHtAlmTjdCOuO6xdgl
         pRBU1qVQQ4ecuPfHmFifsbJcLwJG7EGGdmCAkpYIGcJLxzWIjEuQZsq3qOmvur+nPrL8
         UJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783800450; x=1784405250;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+htTDv5FbsAzj3FUorf5GAcMLrIvoNH3le3blNjkwWo=;
        b=ZnjYd3Ty2A4/SsmSfx+Z25WI+Xm41fpFIt4Xb0b9Xe/HGRDaONnQ/ChqK8Jh7+N89V
         jUW/JTRd9sHMsZ8iQEO4LsqhxnJvF4vTBGQC5Czp8SNxQCBn36kh47BUSjyThDW2t60e
         V1+DR4AaaBrmbz5K57mHSrog7uddGB2lsPNem1oecVxvCRThbdEXNjmUv1XJbY58O9Z/
         UKp2MFNIoE2hXGzLIbUSqv5JJKcqJnsoZ73gqm5TqB4bfV4twZDDRHkWlxzFz3JsVxBm
         DMhtL/7isW+YpUrq2MFyt+dOEmfRLIfi06XcYZxW2kQ6Ocqy+5p5Jmq1E0e35g+SNYmC
         jkEg==
X-Gm-Message-State: AOJu0Yx7iypawP2VLpDaXCm63Nq/KExyaEL809QiBF0Up5WCGz8/80B/
	VNfSBgCXL30tGNAhlaygHLhKuELbgKED7VRg9D7CJDeyv5J2myi+N8Kk59rtFsQm0I8uUX11cTn
	Qyc+iabhxGvUlnOORaLZvbnJVs5noaROP7rWqApnBBA==
X-Gm-Gg: AfdE7clTBH4yGqSmvDANVdfPAVK4DaLGo883BgleGkU95y/JT+xqWwP900DDV5nkagZ
	fOIj+9EpgUZdnxmXHVCp7d18kxAoUQofrPpMhau9EVa1UhRICY2Za2gw7bZQ6XERis4qU1WRb51
	o3HA5RGo8ksGTJKCdJ5+p489MRj0ZRfB50rbE1TzyKiFLVx3wmvhoEGHnKfru1YM9m62+0Hi6aX
	ZDNEpjsrvZgD9l+LkSVoy5Zp4Z1pYSi606siB7/Rd8vTabekETaTmaLU9CXgRK616ZScIOkQA==
X-Received: by 2002:ac8:7f89:0:b0:51a:8c99:1f17 with SMTP id
 d75a77b69052e-51cbf27fa24mr39064351cf.70.1783800449375; Sat, 11 Jul 2026
 13:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lk=?= <aleksman4o@gmail.com>
Date: Sat, 11 Jul 2026 23:07:18 +0300
X-Gm-Features: AVVi8CfSPVc-WBi2jnS7s-0sVusChRAwKZ7vPx_qeOvYLe6vmSpj7OKN3PCI2iI
Message-ID: <CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC+RaJKsKz0sUivGAQHXA@mail.gmail.com>
Subject: [RFC] dbus: expose per-BSS security capabilities
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

NetworkManager cannot currently distinguish WPA2-Personal, WPA3-Personal,
and WPA2/WPA3 transition networks when using its iwd backend.

iwd has the required information internally.  scan_bss stores the WPA and
RSN information elements, and scan_bss_get_rsn_info() exposes the parsed AKM
and cipher information.  However, the stable D-Bus API reduces all of these
personal network variants to Network.Type="psk".  BasicServiceSet currently
exports only Address.

This causes a concrete integration failure.  NetworkManager maps an iwd
Network with Type="psk" to NM_802_11_AP_SEC_KEY_MGMT_PSK.  A saved NM profile
with 802-11-wireless-security.key-mgmt="sae" then fails the normal AP/profile
compatibility check and is removed from Device.AvailableConnections, even
while iwd is successfully connected to the same network using SAE.

Observed with NetworkManager 1.56.1 and iwd 3.12 on a WPA2/WPA3 transition
network:

  NM profile key-mgmt:       sae
  iwd negotiated security:  WPA3-Personal + FT
  NM AP RsnFlags:           0x188 (CCMP + PSK, no SAE)
  NM AvailableConnections:  empty

Would it be acceptable to extend net.connman.iwd.BasicServiceSet with stable
WPA/RSN security capability information?

The information needs to include at least:

  - advertised AKM suites (PSK, FT-PSK, SAE, FT-SAE, and so on)
  - pairwise and group ciphers
  - management frame protection capability and requirement

Per-BSS properties seem preferable to a Network-level value because BSSs in
the same ESS may advertise different capabilities.  A consumer such as
NetworkManager can aggregate the capabilities when presenting the iwd
Network as one logical AP while leaving BSS selection and roaming to iwd.

One possible API shape would be an extensible read-only RSN dictionary on
BasicServiceSet, similar to:

  RSN = {
      "KeyManagement": ["psk", "sae", "ft-sae"],
      "Pairwise": ["ccmp"],
      "Group": "ccmp",
      "ManagementFrameProtection": "optional"
  }

The exact representation is the main subject of this RFC.  Raw suite
selectors, separate properties, or an aggregate Network property may fit
iwd's API conventions better.

A corresponding NetworkManager change would consume these capabilities
instead of synthesizing PSK-only RsnFlags from Network.Type.  Separately, NM
should preserve an SAE-only profile policy in the generated iwd profile by
using:

  [Settings]
  TransitionDisable=true
  DisabledTransitionModes=personal

Related reports and downstream investigation:

  https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1489
  https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1693
  https://invent.kde.org/plasma/plasma-nm/-/merge_requests/571

There was prior discussion indicating that additional BasicServiceSet
properties are welcome when the data already exists in scan_bss:

  https://lore.kernel.org/iwd/97112988-3681-4192-abb2-9a9ee6d9552d@gmail.com/

If this direction is acceptable, I can follow up with the D-Bus
documentation, implementation, and tests after agreeing on the property
format.

Regards,
Aleks
