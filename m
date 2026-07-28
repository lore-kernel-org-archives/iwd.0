Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1832D42B
	for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253701; cv=none; b=rjDHtiIvgLZT2Y/7+OwuAQvh22EJtPmvbiAMJmiDVFLDdbq+AyYRd6UzIC/eZsXXr+MSQdlUZC9m3XuOk8ZERielNY/3/WovHEzygkvq+UdKWwKkV8/us3M8cuEsetLp+vOREIEzNRbl0XwG/UgN1lElFVw0xI3/oR4tsHeAaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253701; c=relaxed/simple;
	bh=mHFxH2sQl63QxA/L8cbG1UCFpIAdUOlv/JVzGo56mGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXsoWmiFRpI84SInptSRoOymIw6fSQSwR4KCK4BbtSZTZOYohi/v3CR5sXgsj4sL1Ulwu0ZHZZsnRTt7bVKHYc8ct5Z9v+/UotixfMvWUxbVAtlA9R3oV/UtoI5FOoQ3ASm7kT4wRD8Th6Xt59c2QDZ437m6GAapeXUMPfqlW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8KRXRrV; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8KRXRrV"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3997a448ecbso39715111fa.0
        for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253697; x=1785858497; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H2VBlJegZLLW7eTmjoTwhFbr3dchf4bJyG9tVReb0vE=;
        b=c8KRXRrVZ2mHTBF22/AJBKgvh8OZNxMrYexbqdlbN/fcJt/IhMUhotwFKWnKbKX0q5
         L8spMJNeRZFHhIMUQH5Qejik9KnsMyAdHiOXXZQ1ITSQ3j2mHiSjfY9OaowrqHPN7fyZ
         aLzzXg0SPt7U68Y7rKwE0rm7BgQyTv7NNUKwK8nNyFEwa9lJKh2Z2ydsupDUwy7F2iLR
         H1x6vM/KAY4wBKJVPUsUIsX6qkDG1Ry5eTbAWTFXDMvl7N/Xtb7BoRjtGKAzT0/+r8GK
         NdMglXR9yETy6p5+RjkW2chzyVE0th2A3ngTHTAnjJE83UFDzW7pfSIuufYVQ/YLNZJ5
         la0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253697; x=1785858497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H2VBlJegZLLW7eTmjoTwhFbr3dchf4bJyG9tVReb0vE=;
        b=MDzpAHR2WHgp6xih9kW2B3K1oON9pqXGzroWH58HYmX6c/59WazvxqG1rew3Wq2eDN
         aIIEKj8wrRxN/KZtwL7qGaGONm3NzajS37cCY1hpbsoPD4MOPVewLapnfjMEtOtY2Tc3
         ajDQ8irLX4mJf2ZHiuhZKVGoOOCAK6Byltqiu35NOesNe9EiqfRyt54rzUWMsQm8DGAL
         2VVE8RTtz407mmH+cAzij4m4QAQvih3xGdOoBm1JqsG0g8AGqA5egUj075eSkWMHloZT
         VR2XfDwwK+X03vBODYFQFCySetkbcymTdz6D8Twvi4nsEx/FciKarz8dd34Rl8GlVoJs
         GClw==
X-Gm-Message-State: AOJu0Yy89MHN10NEk/U5g4YP6SVAi7MkQzkRu+zi9SBbbw3ZiPX0Nu3+
	lhR+NpbiPXqVlsUg9isPdaiZp33Ls4HbDYa8CYEDJkF8YDCdFvPJZ17sFKAGBsIahpl0WA==
X-Gm-Gg: AR+sD111wrxeqXN9AS854r+e0ornwDrT5RuKxby+becokEwgjytNn0l9P5ZwF7cy+rT
	0Hpl9bouF4Tkcs1agCHRAbQAknuf8wjTOeatTwEvwrT7gYFIom1Z2gzMiKlQf4T1Uvtvyz+lxKA
	GLtYaRQjLlgjQZwAnuQBBJBV6UEtIQJadmRL1t+YzW2ijWe53L2b/ejGMieqBGkP2nW4YKHkSQx
	7oEp/7gtJQApTqPgffxhH+eXPPF1xKTjKw2bT+wY/C+NKbDbPJqHsCt2U2UD3Jon/VcyYdGZknp
	o11hQcNETwij+e1Nc96IMGowcz57zjcywXKd8wGbNJytzPBUc+f6wQdoyujxHfVv6IH3hhXeLoW
	t2W9+mYyUOT/1bbUfAAizcdweRaz0sM/dMMZET8gLFgm5vn6IP2TM/eZ8ZgeE4TEcIcXoj3PGL9
	deAFjrB3I3EBqZMGRVtw==
X-Received: by 2002:a2e:bd07:0:b0:39f:1286:c197 with SMTP id 38308e7fff4ca-39f51d45b29mr7057791fa.33.1785253697077;
        Tue, 28 Jul 2026 08:48:17 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f22187e5csm19807431fa.16.2026.07.28.08.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:48:15 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com,
	denkenz@gmail.com
Subject: [PATCH v4 0/5] dbus: expose per-BSS RSN capabilities
Date: Tue, 28 Jul 2026 18:46:39 +0300
Message-ID: <20260728154729.3485557-1-aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <f9cb0ba9-da64-48b1-a8a9-3fe5c463b568@gmail.com>
References: <cover.1784069194.git.aleksman4o@gmail.com> <f9cb0ba9-da64-48b1-a8a9-3fe5c463b568@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

James, thanks for the review.  This revision adds the requested iwctl
support for displaying the new fields.

Network.Type intentionally represents WPA2-Personal, WPA3-Personal, and
transition networks as "psk".  This series exposes the RSN information
that iwd already retains for each BSS so consumers can distinguish those
networks without changing the existing Network API.

The optional BasicServiceSet.RSN dictionary uses the same KeyMgmt,
Pairwise, and Group fields and values as wpa_supplicant's BSS.RSN
property.  NetworkManager can therefore reuse its existing parser rather
than add another translation layer.  Older consumers ignore the optional
property, and consumers can retain their Network.Type fallback for older
iwd versions.

The corresponding NetworkManager MR reads and combines the per-BSS
capabilities for its synthetic ESS access point:
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/merge_requests/2464

Validation:

  - make check: 273 passed, 6 skipped, 0 failed.
  - The installed patched iwd exposes the expected KeyMgmt, Pairwise, and
    Group values on a physical WPA2/WPA3 transition BSS.
  - The new iwctl output displays the capabilities in the get-bsses table.
  - An SAE profile auto-connects after restarting iwd and remains visible
    as connected in NetworkManager and the Plasma applet.
  - A NetworkManager disconnect/reconnect completes without a password
    prompt and reconnects as WPA3-Personal with FT.
  - The upstream CI suite passed all checks for v3.

Changes in v4:
  - Add iwctl parsing and display of the BasicServiceSet RSN dictionary,
    as requested by James.
  - Widen get-bsses property values so the capabilities remain readable
    while the table stays within 80 columns.
  - No changes to patches 1-3.

Changes in v3:
  - Shorten the auto-t filename so the generated patch metadata complies
    with GitLint's 80-column limit.  There are no code changes.

Changes in v2:
  - Resend with git-send-email after the Gmail web client corrupted the
    inline v1 patches.  There are no code changes.

RFC:
https://lore.kernel.org/iwd/CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC%2BRaJKsKz0sUivGAQHXA@mail.gmail.com/

Related NetworkManager issues:
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1489
https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/1693

Aleks Man (5):
  network: expose RSN capabilities on BSS
  doc: document BasicServiceSet RSN property
  auto-t: test BasicServiceSet RSN property
  client: display BasicServiceSet RSN property
  client: widen BSS property value column

 .../testBasicServiceSetRSN/bss_rsn_test.py    |  70 +++++++++++
 autotests/testBasicServiceSetRSN/hw.conf      |   9 ++
 autotests/testBasicServiceSetRSN/ssidSAE.conf |  11 ++
 .../ssidTransition.conf                       |  12 ++
 .../testBasicServiceSetRSN/ssidWPA2.conf      |   8 ++
 client/bss.c                                  |  76 ++++++++++++
 client/station.c                              |   4 +-
 doc/basic-service-set.txt                     |  23 ++++
 src/network.c                                 | 110 ++++++++++++++++++
 9 files changed, 321 insertions(+), 2 deletions(-)
 create mode 100644 autotests/testBasicServiceSetRSN/bss_rsn_test.py
 create mode 100644 autotests/testBasicServiceSetRSN/hw.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidSAE.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidTransition.conf
 create mode 100644 autotests/testBasicServiceSetRSN/ssidWPA2.conf

-- 
2.55.0
