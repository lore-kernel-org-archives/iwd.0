Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E976C15098F
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411478; cv=none; b=TTjSvXN3SNVeztV7W/3l7tVbR8x3Mq2nQ3fx5QyoC5FG0ScPEYGzKdsXdpmwoWB1utVS6oylrsGqcsZM906/PskAVyzYcEnZ0DqbcICmMNgtrqh2a/n2mUh9d/C86+4nunEQeaQB20iALAwcSnAjf4EkDILoVRn9dGZ5Ylruwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411478; c=relaxed/simple;
	bh=vcRGpW2tzqXCoQzUWQ040eQWrJE3YQFoq2QhY1y/CNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=odFumOBCXduEyog5eRSJSk1PUO8Z/LuXnVA5/wsp8SxZtNNBqLAlT1Uh0dRNzmRTSBBiap0HvwHel3maMXhqpU+oGJ9MK1S8BCus1SDQk6HGwNB3l4IdFmKQudFpNvnock3iRtFt4HzhA5w+DwwiueRMvhVYyiWcOxf5G9xLcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK9zJJ4/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK9zJJ4/"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476f4e9cf92so47291671cf.3
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745411474; x=1746016274; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OHz9+TQlFytMxrpWkpS54kdYdFSPdLKnyfEqmRy6Or4=;
        b=gK9zJJ4/Kudu1dGAsZue2JxEJrZ4SbKT/2HGUJCe4pzVX2cSZ8ewv54/ZnZF+hlkXj
         gqbrfqf3jqUuaa1OHQEW+g7N2lsKhj3kgzgPZzEKREB4p5d4XChbOVcP5ScdRkH441h7
         lmt8GuBCHaU7cpLZTg9AK3N3eKiyt3BAKRCgE6rxQBibbeKkuWADNUbjeFUo+bEVDxcp
         rAIxKOZSb9J+ZG2LejNJb2K7K72O7JCItI5BPcqLMysVs8VhkBHTRAmrpwp7vmn/g9KH
         HBs0EGnqk7DgceD/MXXM0v5lXANrDUqgWCRdbJsie63/CfNOK/Ql7wfjGNx8aW5vl0/r
         OsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745411474; x=1746016274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHz9+TQlFytMxrpWkpS54kdYdFSPdLKnyfEqmRy6Or4=;
        b=cWwGX3CKdzr2tHz1Tnz/DVSuF1wWE+M+z0mBXgHgCzyTekzzEAiH6hXLfYixt2x6Cc
         Xc3y4eBKhyFhHPuwgg8LdqZtB7FKM+jkYqh8+8ykew7pvg7YK4PIE8ldV7VtR5LYGsKp
         YOurfYLV8EXnEG9yrVLQn4UM8E5+Tr+041ynwQ89R8EVHA5n1ZXuEQDl/hmAzVED7FWS
         etSIGHbBKGwyVO/njAQpOOtrPpn56ZlBAmoml26REpfOaUiQG+M37iUsxxjmcXLKxpXx
         HBcD74g9ApFF8VA4Zoc+qDXzuJsEu4YpCIRGi9U3Y3rCAFZr20pdZ4NMgzNDEr217ptA
         l8vw==
X-Forwarded-Encrypted: i=1; AJvYcCVEkOa3M+XNplVtiyYIkSZE6TufoyF6lUUigJj7O+nAnbUXvm56lCDXZrBpGPHVZfvRuUY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/Rce0np/EHYNfY7TXXQp2CwKdjonDfoTT5+Io0k6a3D/+GJl+
	CskL+5du7qsLzSnCvKpswbcD7mxWnkUwkdF+ZTqrnxGwvzYeSKfp
X-Gm-Gg: ASbGnctfUqYrxq3/iNjaJN/SGRulNH79K/Ip0C7ciF3ION+HT+i9SaKAc5+tDifFWfN
	sE5/06dDKgT+g1T4GMcSks2Gn5TK1ggC9gnSA4tWnsM1qFh3f9QLQZTtyB8fBqVRFBO5ll3aHKy
	of8ay11HDmEwyAjYOVIN2RJ+q07HPTSWghA5B5XDjyz3qE0Ud9uju88PlwyLNqzWdoyhOG/P7DP
	x0/Tq3tTmSmjnKR3ylwugWaR5n4TvK0w5MVfwe94mt1sJ6sYpQFGzMijdVqAey27Jed1fhXPI/D
	kWY3klAxl1iDkIylU3PyN/k3yvJVJl4JcrOFtC/B9u1P
X-Google-Smtp-Source: AGHT+IGdTBbaOkgq10qwMxZrJPnxtvVKDRmBrsgLl51NwcyxI4iUTFmnuMmGXUs4/CYPmbH+wTx9ZQ==
X-Received: by 2002:a05:622a:130a:b0:476:7e6b:d291 with SMTP id d75a77b69052e-47aec4c5604mr315220471cf.37.1745411474526;
        Wed, 23 Apr 2025 05:31:14 -0700 (PDT)
Received: from [10.100.102.94] ([50.170.153.203])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c17673sm67558021cf.13.2025.04.23.05.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 05:31:14 -0700 (PDT)
Message-ID: <7472fc9c-7e56-4bc7-bc70-18c6ca7633d3@gmail.com>
Date: Wed, 23 Apr 2025 08:31:13 -0400
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wl18xx: iwd needs to be restarted before (a particular) AP
 appears
To: Donald <sirspudd@gmail.com>, iwd@lists.linux.dev
References: <CAOVeLGSPJneA66x_3Ov6HRs9YoUcY0bauH7qe+pLDs0qWpBLkg@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAOVeLGSPJneA66x_3Ov6HRs9YoUcY0bauH7qe+pLDs0qWpBLkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Donald,

On 4/23/25 12:33 AM, Donald wrote:
> Top of the morning,
>
> I am seeing a quirk against wl18xx, where the first time iwd is
> launched it fails to see certain APs and produces:
>
> Received error during CMD_TRIGGER_SCAN: Invalid argument (22)
>
> on relaunch of iwd, this CMD_TRIGGER_SCAN error does not manifest and
> the AP in question is visible. Some APs are visible, but not the one
> we happen to be interested in.
>
> I see a bug from the distant past which alludes to this:
>
> https://lore.kernel.org/all/f4d9e6cf-f7e4-49b9-adbf-92dbc006812a@gmail.com/T/#m6fd56354e1cdb32233adcce414bd8ff098c011da
>
> and which demonstrates the same error message/symptoms. but adding:
>
> [DriverQuirks]
> DefaultInterface=wl18xx
>
> to main.conf does not change the outcome.
>
> I am running:
>
> commit 7d5bcd738bb92cd33756985ffd2c4c67452a7f85 (tag: 3.6,
> origin/master, origin/HEAD)
> Author: Marcel Holtmann <marcel@holtmann.org>
> Date:   Wed Apr 2 15:05:43 2025 +0200
>
>      Release 3.6
>
> against:
>
> commit c5e32b0a3c19f6cf40241e323e02dff00810406e (tag: v6.13.5)
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Thu Feb 27 04:34:22 2025 -0800
>
>      Linux 6.13.5
>
> The only solution I have found which consistently works is to run:
>
> timeout 1 /usr/libexec/iwd &> /dev/null
>
> exec /usr/libexec/iwd
>
> in my systemd service, which consistently works.
>
> It warrants mentioning that:
>
> iwctl station wlan0 scan && iwctl station wlan0 get-networks
>
> does not show the desired AP on first run of the restarted iwd daemon,
> but when running this a second time I can see/connect.
>
> So start iwd, restart iwd, scan, scan, get-networks - success
>
> Yours sincerely,
> Donald

Do you see this behavior with wpa_supplicant? If not, could you do an 
iwmon capture of both wpa_supplicant working, and IWD not working. That 
would let me see potentially what field IWD is sending that the driver 
doesn't like (assuming wpa_supplicant does function as expected).

https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/debugging.html

(iwmon section)

Thanks,

James

