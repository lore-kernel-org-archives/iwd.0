Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD284F615
	for <iwd@lists.linux.dev>; Tue, 23 Jul 2024 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721778881; cv=none; b=dpzJs+oPPeoyjrS7wbGrP0jArFtKm5UHCI4DGtoGMe6ToS+Bbb3xUgRh+BB6HXK5/MURWzdKz/slwBT8O1MjaphUVGC7vAeFpr927N2tyWCy8HhdSUmz3x9nEPGdkMgljaM5o95KfNTfA7Fwti8YLaRjoea7d4QI98IWee5K7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721778881; c=relaxed/simple;
	bh=/yeXEmu5BogJDlSEWM1iEuNFCBJso4BX4k1oOoKL8hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r87bn0gDMXKdRNDM/UjcJdJFR+c2eoRpBoXiT2B9hs9u40XcaRlO2usTYexrsSzh7rsBY3ZEpvT/sAOGA1jbXnIyIGZ6GjLWeO3c7aU27rwF5rTBCemQBbnEAwbgRAX5DulrRxI0M2RRJ6KM2MSGvEG0xJuj4xFNKyJx/jZlNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWNjSBVX; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWNjSBVX"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-708b273b437so3309730a34.0
        for <iwd@lists.linux.dev>; Tue, 23 Jul 2024 16:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721778879; x=1722383679; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Jgonj7YBEcdRSWqg9cVvOLmdPOv4aZN3Nv1fnxIq+o=;
        b=IWNjSBVXKbffmD1Rwo7QQom5lVn02Gd8CYYsJTvjHcjLnWfzgthjApEujXDxLlwrOX
         ntyOcNP65B2nrI41C8lpCN6uY4Z93IZhTd3HZZQDC0kyYqF+oaA+n8F2SSzh04C7sJ7N
         I4itzsvKsofeoh+jX3Dk16Uz4h0rDQxOerTh70G+wmlFn1UwNtnpVURbPiE8e8Kb9NqA
         4NwJoBpisSCkALXOji/qHVvYvUqWSW8UsZujBjxVlCWAULlz1kxDDI9JobNAx9UQMqtV
         lZvg65Cau+W9Jhdko2hmEp8V50GFb0Gb7a4wRBAr40550heyV4ducqm/0RDAd2v+FW+E
         rZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721778879; x=1722383679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Jgonj7YBEcdRSWqg9cVvOLmdPOv4aZN3Nv1fnxIq+o=;
        b=nvquC05RCvN4r9GMWCbdVDLo9xcwQOR7YC6EvioWfx7fAdYBC6pg4cxypjTVZvlQ73
         U54rmDk5dEAEJ0ReTej5PSuICj/DuylRylmwp+m+nZJ/mKMoPCTdzJeszvKic4BE6e1u
         XPMSK031mw9vyHj4xacedc3/EONBzwbm3XyOcB9NGRqjjJ7lNo+DjnWLn2Xp2w0x3cVA
         vnKLMpAXh0r2STRqQcDX+6S1k9pOJUeWGBpGZvGBHmMj8RnAc3ltYvjmZALEdA1oYBzs
         I6czAN2uctKoS8ALd82KU0KJ5OlFSAmOyDrs9vopIm4EL+9+8L3yR/5zbHPU8XhXmDEF
         BZgA==
X-Forwarded-Encrypted: i=1; AJvYcCXepGFWr15//oaVoe2ssFl/2wv69wrmKttrze4C92fwDYAdtYFN40xcVO4RfgKMshPq+WKm13NXhg2VxxPtgAbSDJyR
X-Gm-Message-State: AOJu0YxT2luGGrwVhWVClpvQAigGzEq21HkTgOwEyEbyjtEsVbR+wbPO
	B3d7rh1bf17oMrtSjsY07c9TRTBaoP3cKnWBU3bAyfQjic2M7nAKDXoVZHy3
X-Google-Smtp-Source: AGHT+IEoxXb/NVOIn7qEy0QBAKZXF8oeAzFjStwxnR04CLrFbQ/ALhpcp1omiW8v3453Em5FDF3KTQ==
X-Received: by 2002:a05:6830:490c:b0:708:5f27:ce89 with SMTP id 46e09a7af769-709252b9121mr521987a34.14.1721778878817;
        Tue, 23 Jul 2024 16:54:38 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-708f619100asm2238553a34.74.2024.07.23.16.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 16:54:38 -0700 (PDT)
Message-ID: <b45e9c22-b36c-4e96-86a2-d44dc24ed505@gmail.com>
Date: Tue, 23 Jul 2024 18:54:37 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] client: use display_table_row for IPv6 in station
To: Yuki Sireneva <yuki.utk8g@gmail.com>, iwd@lists.linux.dev
References: <20240723161817.2191843-1-yuki.utk8g@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240723161817.2191843-1-yuki.utk8g@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yuki,

On 7/23/24 11:18 AM, Yuki Sireneva wrote:
> IPv6 address entry was not updated to use display_table_row which led to
> a shifted line in table, as shown below:
> 
>      $ iwctl station wlan0 show | head | sed 's| |.|g'
>      .................................Station:.wlan0................................
>      --------------------------------------------------------------------------------
>      ..Settable..Property..............Value..........................................
>      --------------------------------------------------------------------------------
>      ............Scanning..............no...............................................
>      ............State.................connected........................................
>      ............Connected.network.....Clannad.Legacy...................................
>      ............IPv4.address..........192.168.1.12.....................................
>      ............IPv6.address........fdc3:541d:864f:0:96db:c9ff:fe36:b15............
>      ............ConnectedBss..........cc:d8:43:77:91:0e................................
> 
> This patch aligns IPv6 address line with other lines in the table.
> 
> Fixes: 35dd2c08219a (client: update station to use display_table_row, 2022-07-07)
> ---
>   client/station.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis
