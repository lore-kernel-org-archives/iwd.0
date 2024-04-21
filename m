Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062511737
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713703872; cv=none; b=k+0Z0FBayLpNlV/fDUxOmbw5T2KsrXG0IpUhS6rYuZEEaZ3kEOmLeoeWM+auvo+lGHpA11iL5wUj7+eBRGnueL4MEgh+ALZZ90313HDEDwk/0dDdsvy5gLAE415+QNW4Z7f8EXtb71Sn9dw7t44UwXlLUOD6i2nCKwymL+Gaz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713703872; c=relaxed/simple;
	bh=J9Rn/FR5E1tGa8VrNV/pi1VEHhcSj7m7zzmTGr7MHiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRjcnXwo9dPIs2h5L7VeRVQ09Aq/FYTFCjZVdx+ZwK4EtQjpgnpll9QYPllXFFx/dJ7asOSUd8dbMXX2RWtIKV8M2xsxenYO9+/YyjNLRmgsaDEuYrMWVGBiLC+VH8SptGNjz+sb3KrSITwmW/Yiw4QQsW0B1r8iKwZMvCdKR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ar5KHzes; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ar5KHzes"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so3817359b3a.3
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713703871; x=1714308671; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gpt8K2vhnuzD0at2tfzSZbfbI6JcdBprqXGsiTN2AJ8=;
        b=ar5KHzes5/y8ET32mDHIyhpH42YI9c6Ilbe2z9xr3eH8vAVUFkyz7AwlLWgIAi2/29
         macAi6tCCr3Y8iTq6rok66bhiYqDGqk0b6iXZYgstT95BcHl1lUTeBxdhF0vngqTk+Kn
         5Iqlyk3cpk8ZbcgoioKxQKKPLYbDYFWZ6ZtYQXouWOcy/t8D/cw5mA9UsiBdwDIik50i
         f4JNPOmGgKDlVMDF0e/eDhBdV0JA8u8765qV15gOFk8n8ViySFL+h0wZ8XIYDRseqDEx
         +Jy0RWdEaZvhYUDqjtSznm56M9BhS2+2TzI6iCgJI2J1kOoBxM8mhvNirpYlw3JYzf3f
         gP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713703871; x=1714308671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gpt8K2vhnuzD0at2tfzSZbfbI6JcdBprqXGsiTN2AJ8=;
        b=YC0b2F9FvdA5+OLf/A6PXOGZtl2qwq+p+yamzXhEDo2mbF/Bf5F3Sadumr0X3khy+X
         b3zg7Uf2k+wX84jAVBzXfCRv8uOhXP1VdOo4K5QxCqOKkiVhBbmZyrVpeVDDDHx1jMbw
         U1PmXaa3bF0X7Z5vFl8U4nqJ5R4W+bv69GfFUpUWUPGVv8hnJPEQ5Ko8GdXMVCLcnSgy
         U8JRV2jO1QOxhpbdcGnRQ59dt45KuvsHGUDQ5d+3hBljmtD2KJWB7J2feUyQveEym1n7
         ipV0p3do1PayFws7oikha4RVFCLvVMsbnaFqW9yLgj1QJ8Mx+vhY5m0L7rG3P6E4iugp
         dxcw==
X-Gm-Message-State: AOJu0YxhDV1OP6zAsW2+Pqjpd0KZ/1g+NUQLs9DJdBZ9VtuthFb4GmB8
	1mdruL+T7pfiFNMeITb7pn0+CkYwoRSRxIzzbJehNkSgKm2VzkRU/CzIXPUrDEs=
X-Google-Smtp-Source: AGHT+IFjb39ErxS0zzf2Ao08x4O5cEIjJBwvNBIWzXDkfTw09KPawrZzQORQ/h05NFAZud76gmENHg==
X-Received: by 2002:a05:6a20:9717:b0:1a3:1972:450e with SMTP id hr23-20020a056a20971700b001a31972450emr7669465pzc.50.1713703870628;
        Sun, 21 Apr 2024 05:51:10 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id kr3-20020a056a004b4300b006ed26aa0ae6sm6116709pfb.54.2024.04.21.05.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:51:10 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 00/11] Basic SAE support for AP mode
Date: Sun, 21 Apr 2024 05:50:30 -0700
Message-ID: <20240421125050.6649-1-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches adds basic SAE support for IWD in AP mode. It has
been tested by connecting to IWD AP using wpa_supplicant. Note that this
does not yet correspond to WPA3, since WPA3 would also require the
support of Management Frame Protection.

Normal client functionality has also been confirmed to still work. After
applying these patches it remains possible for IWD client to connect to
WPA3/SAE network.

Remaining TODOs are to include better sanity-checking of received
frames.

John Brandt (11):
  ap: ability to advertise PSK and SAE
  ap: accept PSK/SAE in auth depending on config
  sae: add function sae_set_group
  sae: refactor and add function sae_calculate_keys
  sae: make sae_process_commit callable in AP mode
  sae: verify offered group in AP mode
  sae: support reception of Confirm frame by AP
  ap: add support to handle SAE authentication
  ap: enable start of 4-way HS after SAE
  eapol: support PTK derivation with SHA256
  eapol: encrypt key data for AKM-defined ciphers

 src/ap.c    | 135 +++++++++++++++++++++++++++++++++-------
 src/eapol.c |  58 ++++++++++++-----
 src/sae.c   | 175 +++++++++++++++++++++++++++++++++-------------------
 3 files changed, 265 insertions(+), 103 deletions(-)

-- 
2.44.0

