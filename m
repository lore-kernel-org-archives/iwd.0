Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061FE2FC35
	for <iwd@lists.linux.dev>; Sat, 25 Nov 2023 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5uOrSOQ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5cece20f006so7522077b3.3
        for <iwd@lists.linux.dev>; Sat, 25 Nov 2023 11:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700941614; x=1701546414; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I7ohNBdp/QwbOjcUeQrXn+ZXo9Y4FKGEq7ekRQY8Sus=;
        b=c5uOrSOQcT7jnAU21EqlpbvacuYWawoKRNf6IzodUF0lg2VfnBThjhWPknpRaDZILL
         l/1K7Zp5J1RBzHwsDf5aw6F7u6tuo6DFhkiC0sFOGooRRPWRRgk8fZedhjDjUJ4ytQFz
         IUXEhVt9gazkjKiCJoftaL5Q/dUpMIwl5J82fcVhH45k6BVcgMVp9SxCx17YmiWrjepD
         Fblz17/lceVXmfJIOG5FPtczv4Sv2Z21LYodvP9szdBChR6hj+X17ugBJSPla1MCoEDh
         OCQpCKOqax3PZWcT7Y/7UmuTpdYFzra1qBKLdlTxUWu8OCZUyD2Pd1Na9z5e+IMJQDOt
         jggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700941614; x=1701546414;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7ohNBdp/QwbOjcUeQrXn+ZXo9Y4FKGEq7ekRQY8Sus=;
        b=uFD7H7rNov4UtZ4t8LB+gKnchVAu+KxdhgfSe7wChrdgB7gVL6ZjqL+BAaANm89Al6
         kDKTyH5x75vZL997oh8sVdoIInfOqf/9mJX7YLIFmomlclTDGViWR2bvGlKVTkeST8XF
         J1jdnAqarlfB1RYDWOimp9XBFRqk2otLzt+bzQUy+EjCb+Vb0tZIjtFsRptaZuAtKL4n
         iOcebO6MpDDFBpF4PwUsW5xD5ooTe1NJmysd4cSnN0m82T+HKBucGhwVxVDhdKJeeB5T
         F3Qs9XAuUfFtv+OekaVSEJZiHspLy2UxxUpl9UMiJE+NqIT4XP34p/IgtUl+S/pXfERb
         eTnA==
X-Gm-Message-State: AOJu0Yx/HlCyEpn96US8wdKfoMw7f0bh4XtsB68KNUzxr4/R9IMpoZ/H
	hIQtQzYs8xl/oo9TN+jojHA1xfh3hcwQNZ1qjm2ETkgLIzc=
X-Google-Smtp-Source: AGHT+IHZ33Wq8JcpMzWyqN1U7pxbitUdN7GI3iI799qGVwCDuRNpyPcnVSU54bZfi3uvLwoR2LCeKDA+ovcW8afiTKs=
X-Received: by 2002:a5b:14d:0:b0:da0:9735:b012 with SMTP id
 c13-20020a5b014d000000b00da09735b012mr6212051ybp.11.1700941614602; Sat, 25
 Nov 2023 11:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Daniel Barter <danielbarter@gmail.com>
Date: Sat, 25 Nov 2023 11:46:43 -0800
Message-ID: <CAJODeCBYQ3bwRjZjZoZ+AX+QG84U=VO_UEoa0AuWmFAqxunn4Q@mail.gmail.com>
Subject: roaming issues on a residential LAN with multiple APs
To: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I recently added a second wireless AP to my home LAN. All devices
except a laptop running iwd are able to roam successfully between the
two APs.

Laptop is running iwd 2.8 with the following config:

$ cat /etc/iwd/main.conf
[General]
RoamRetryInterval=10
UseDefaultInterface=false

 Running it with --developer and --debug flags, I am able to see both
APs using debug wlan0 get-networks:

<SSID>
      40:b0:76:ad:6f:2e  -61   5600    3192      000000
      40:b0:76:22:27:de  -67   5280    2128      000000
      40:b0:76:ad:6f:2a  -60   2447    1227      000000
      40:b0:76:22:27:da  -72   2437    306       000000

moreover, I am able so successfully roam from one to the other
manually by running debug wlan0 roam <BSSID>, which runs
src/station.c:station_force_roam(). Also, disconnecting and
reconnecting manually, iwd will connected to the best AP. The issue
seems to be that iwd is not automatically roaming when signal gets
bad. The only error I am seeing in the logs is

iwd[32079]: src/station.c:station_early_neighbor_report_cb() ifindex:
5, error: -110(Connection timed out)

which seems like it could be related.

apologies if this is the wrong place for asking such a question,
presumably I am just missing something obvious. Happy to provide any
more information which would help diagnose the issue.

- Daniel
