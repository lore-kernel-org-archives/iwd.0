Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFCC1384B3
	for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664988; cv=none; b=kITELGIYF2KwQWExZOv8qv7fKRcSUWtmxSxGKCbPZX66MAmDopUe+MeT+zgQ0iN5ImOU8AyyVF4P0xU/fF/KU7MgH7zQuAfTq2RmZ/1EcNpdfQbBDrRwYg7prYIOVpheymjATRkK5lJwRAjETWcH02Y88h7JhOTDkDQ0tl95gSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664988; c=relaxed/simple;
	bh=Jq7ooCio/lqF6BJyoYlYmfMub+SsWFvakSG4bMRDMQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NnpLvnlSJVCzcoWEkojAUPb2nPibSuERD4xE9MJBylHLjuHtW7N8iRY/LCwCsJJaY0cqxH01WG+m0L4Ui0onOx6MEgd6alRTEHtrBqe4EJm/MYF6x04mDoVDlLX7LZjoXawg0k50vh3cTYgTwy2+wIUY4un6fol/WmnPzWqz9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S28Z939b; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S28Z939b"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a56710cdccso607677eaf.3
        for <iwd@lists.linux.dev>; Thu, 28 Mar 2024 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711664986; x=1712269786; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/DVDFiOnXA51QUjmuAkfrgeZPJoQNBS8cBL0C4O1y9A=;
        b=S28Z939bnsxW57WYcZM9/dj9DqvAaVQucnVSafSYs1otrHhLbzrddCUZy5ipFVq0JP
         vwr46kjSIdkpX6Ylk6o6iNCGa20NM+Hslo0I5CdE1ms2YGAKkdL2iVAJbyYKamOFxMID
         jes1qmp0faU1sUM0cDEiovvCoGhrZb4CU+oVIxptl1Aalvo+QVOzL4V1c1xDVGsHzjOF
         WL9LMdqqDPNVNwoXITesNCJa87/E60xQApe7/z/hEjkfVde5YSxz01wv2l7Spd2bEO1w
         P1XlUzsHQfZyikKZ+qTq7FQ19umVwFUTQfOyC8rwAckGVuBelswMJRMZs7U8GhfG7/0N
         DdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711664986; x=1712269786;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DVDFiOnXA51QUjmuAkfrgeZPJoQNBS8cBL0C4O1y9A=;
        b=E02t7ko3vNE4iG//5pFLnwDiJWMUZiZ+uQoQQruZxahsl0ir5mrbkuDJEAr0eJ1Uo3
         T1PrLRAT7ueM6lltYEfCy6BaE0fYrP/a07fxMpg4oJXTk9Z7sVwKUsBBGd2Otnz8eDxY
         6KqI2AJaS4hWIWdWd1wgFU0pAwSqUwXMEQdC9Ya0K/ln72pDkK2ORkK0FYQTzpReU5pU
         BpIHm2O8GyppYuCtI0UAHwM40xnXF/eLuP1c0ALfFOp+TvFATLOebGaTtWZT9HADNJpd
         /+LIovlM4ppsn32WQ9t/LeBOmD0baG7Az8Lh/FeZSxngpmp9SHHTDpo66edBKsS1P114
         aVIA==
X-Forwarded-Encrypted: i=1; AJvYcCXILuCZmTvcfQvYuVlIE47mxsAKW6nF8/mpzBbk+ehHQxKZ5nxeZP+M2Gr3YN0YjpRITDwUoXkmthNgyrf4vRPH7dMN
X-Gm-Message-State: AOJu0YxWAeK/t2uCerJewyowwulDnXA5J/IWr6gTihgIbEQdosxEzwTQ
	QGhzOJRWnQqTBy4w4O9QqdTuBHx77pNJykQb6OqZE89KuspPpE0q
X-Google-Smtp-Source: AGHT+IFRPZDXm/+R9nt3Ifpv9NA03OxMvRU8RGKEg4a9u+sxSyZlZdoipLlHSJqh/3hKDZJn3F+Rpw==
X-Received: by 2002:a05:6820:1e17:b0:5a5:1f92:ba2b with SMTP id dh23-20020a0568201e1700b005a51f92ba2bmr502864oob.2.1711664985966;
        Thu, 28 Mar 2024 15:29:45 -0700 (PDT)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id bi11-20020a05682008cb00b005a586b0906esm485473oob.26.2024.03.28.15.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 15:29:45 -0700 (PDT)
Message-ID: <330aae8b-d7db-4368-b4d7-f218b5074579@gmail.com>
Date: Thu, 28 Mar 2024 17:29:44 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: use CMD_DEAUTHENTICATE when needed on disconnect
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240328173745.1574384-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240328173745.1574384-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 3/28/24 12:37, James Prestwood wrote:
> netdev_disconnect() was unconditionally sending CMD_DISCONNECT which
> is not the right behavior when IWD has not associated. This means
> that if a connection was started then immediately canceled with
> the Disconnect() method the kernel would continue to authenticate.
> 
> Instead if IWD has not yet associated it should send a deauth
> command which causes the kernel to correctly cleanup its state and
> stop trying to authenticate.
> 
> Below are logs showing the behavior. Autoconnect is started followed
> immediately by a DBus Disconnect call, yet the kernel continues
> sending authenticate events.
> 
> event: state, old: autoconnect_quick, new: connecting (auto)
> src/scan.c:scan_cancel() Trying to cancel scan id 1 for wdev 7d
> src/wiphy.c:wiphy_radio_work_done() Work item 1 done
> src/wiphy.c:wiphy_radio_work_next() Starting work item 2
> src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
> src/station.c:station_dbus_disconnect()
> src/station.c:station_reset_connection_state() 85
> src/station.c:station_roam_state_clear() 85
> event: state, old: connecting (auto), new: disconnecting
> src/wiphy.c:wiphy_radio_work_done() Work item 2 done
> src/station.c:station_connect_cb() 85, result: 5
> src/station.c:station_disconnect_cb() 85, success: 1
> event: state, old: disconnecting, new: disconnected
> src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
> src/netdev.c:netdev_authenticate_event()
> Unexpected connection related event -- is another supplicant running?
> src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
> src/netdev.c:netdev_authenticate_event()
> Unexpected connection related event -- is another supplicant running?
> src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
> src/netdev.c:netdev_authenticate_event()
> Unexpected connection related event -- is another supplicant running?
> src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
> src/netdev.c:netdev_authenticate_event()
> Unexpected connection related event -- is another supplicant running?
> ---
>   src/netdev.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

