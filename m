Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7B4315F
	for <iwd@lists.linux.dev>; Sat, 12 Apr 2025 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483703; cv=none; b=MaTGVtIJjlZJI/PJF+jeWuW869rD3czyjH/gcVTmGbFpjRGJAkpTkTsLGUXkmn8BzZJqvwncsfpL2csFogn/EL8UzpX9V4yLRjzKjOru7o5JInbuHvbSDCGCAKbXMgQBhcc7a9d4e5SrXgDDRKcQqgb2B++ZR3fXeIIfTGNSTGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483703; c=relaxed/simple;
	bh=vCbzLW3HLUynfIcVA4liH8c4PJ0aNdjFJjOLYevEqOY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HtLM/fay3g5QNQiMqTzoU28CrN/FUADQodRzL0LxpBeT4mDywERjwMWhgyGD/7HhBBY/aDN29EcUk6uD1RlxhnnV8nZJDU8YRjcsqHwVexJbog4j9h8/4Ej1q556BCev76FMfrHuNVPKi1Fj7Uv3e+Bdt0vGpdKYbSO9F9AbhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkaVWovU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkaVWovU"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30572effb26so2794821a91.0
        for <iwd@lists.linux.dev>; Sat, 12 Apr 2025 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744483701; x=1745088501; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3F4tL9MD76vZwTzoN3mN0H54b8gLG6tYx5I9C6FHR2M=;
        b=KkaVWovUCbkIM7W6FNxzTC/fLpUVwIkXB64+laHmSIN1DAwribhtmeG7/OvE5eg5AJ
         /OsKvLT3+IOWkxGR8qbp9xmuiCwCOcH9crRDk7hyKjZqOT1kcdbKM+MFADCAgswYyS4N
         LYwYF1cQMS8Xr3K08I3BTVXjIlmZThTtCdnyReEP7X87NszdT2tALRVhjEnVoRi9Tuaz
         Ia04PjqgUcJwIOsUizRb5po5bsP7LEKzboK51XEsp1mRlGtwETXXKItR+aYz+vjipj5f
         dYFIee94MjpBJB0X2sWIzu6KMe5pvm4e0uaZLml7FvSdrOPFVhtLXSr+pIyy0V0AWHnd
         vB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744483701; x=1745088501;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3F4tL9MD76vZwTzoN3mN0H54b8gLG6tYx5I9C6FHR2M=;
        b=qVvo1sPNVD7dYdXYGm4j0oz/BZ7N2hHecVCFwcS5ve3STpwWJ55bof8BYVgf0TWjM2
         8Ep4ise23b5/E/dUANopgPXkFhzuLtv/fZFi2g3kUi6XO04WVQEMl5n7kVEovqH/r8kD
         t3rI57vKjJgUuH/vpcUYrbcNLUlxhL06ilft7iAJUD2wpsD3XpUvz0W93YgiNzUMGHzT
         wGE+1QaK2XwgoHW5irfrimh/T8u0CXU73/Yvdvl/3YxrwdI4vT4Mp74kxdHJk5IGZsl6
         jWbz9rh59TWsJiTBNakirL+Rj9TE/4uZpDDGTFPaDD3DkjNKDj1AEx9+rnMQ+qIh83ng
         94Rw==
X-Gm-Message-State: AOJu0YwopMCX2y9YEQ2642ojdiIrhKVRK5KK7Sw9zn3SDiWJnzLZ7Q2w
	qqy3rTXHToerT/gscE4VDj9lyuqmPjgTyG6OlHOTPH9T1N027KLVh/D5BJVMYOW1TQbhQVdqu5V
	JjTD8aLpNPWG6q/bksKEuq5mzD6IJU8tp
X-Gm-Gg: ASbGncsNl/1QEx0uSQzhC1vdUXsCCS2IM+4O7leZ4IB4uzIEjfkUrUPIlDnafsg9d+V
	FIrI2/LuRNP7GXFLqlWEyVhGNMLKq9cLTLjOQKOxVlwJJD/9ig3eg76I0W3O04nIZyIafDCyCly
	hZh0LAUTeIZPVkGbff4FnkrsevidNs1UefpfQ=
X-Google-Smtp-Source: AGHT+IHo9+0zxSNaZ//FVq11aWyjLz4d84OU09OOhjc4H0U6KB0L4jowdW1CZHxtSjdABF2V+nkV93n5Cf9F1Mg1Qa8=
X-Received: by 2002:a17:90b:574f:b0:2fe:9e6c:add9 with SMTP id
 98e67ed59e1d1-3082367ddb6mr12098635a91.18.1744483701381; Sat, 12 Apr 2025
 11:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 12 Apr 2025 13:48:09 -0500
X-Gm-Features: ATxdqUF904V98LmqcBaLvMM8nhcxRv7q1fNdNGJpFdcsoeRyTYbA_np6N0hQHj0
Message-ID: <CAG17S_NCdQ39dBaKtNdiF5yWcX=sgpppPxqhifM+Oik4o=s==A@mail.gmail.com>
Subject: how to get scanned network strength over dbus
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I am trying to get a listing of ssid Dbm values for my UI. I an trying
to write a python script to do that and ran across the ones in the iwd
directrory
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/test
I copied get-diagnostics and ran it and it works for the conneced
network. How do I get the dBm values for all scanned networks?
# python3 get-diagnostics.py /net/connman/iwd/0/3
ConnectedBss : a6:2e:48:fd:9e:73
RSSI : -57 dBm
TxBitrate : 292500 Kbps
RxBitrate : 292500 Kbps

but I want this for all the scanned networks... Is this possible
across the dBus?
if I disconnect the network and try again, I get this:
# python3 get-diagnostics.py /net/connman/iwd/0/3
Traceback (most recent call last):
  File "/root/bob/get-diagnostics.py", line 27, in <module>
    diagnostics = device.GetDiagnostics()
                  ^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 72, in __call__
    return self._proxy_method(*args, **keywords)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 141, in __call__
    return self._connection.call_blocking(self._named_service,
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/dbus/connection.py", line 634,
in call_blocking
    reply_message = self.send_message_with_reply_and_block(
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.NotFound: No
matching method found

I get something similar if I put the ascii name of the network there as well:
# python3 get-diagnostics.py /net/connman/iwd/0/3/73706735_psk

Is there a way?

Keith
