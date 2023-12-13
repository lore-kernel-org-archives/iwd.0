Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E538BA49
	for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSdr+OsN"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f055438492so5620761fac.3
        for <iwd@lists.linux.dev>; Wed, 13 Dec 2023 14:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702508386; x=1703113186; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNCEG9XLO18BtpVTafkinlcABzPXAnc1ejK5b0Uz2xE=;
        b=kSdr+OsNy5rnuSbciTrSXUrPSQbNnhUVRGKTFiY5ss2Uml7yc4l5JvijS7mGxOpnOp
         9ReR8C8YVFrjgT3DHCNlES60ayR5upssIVpN2/7hyzHEIptWHq/lCxgWG/wnATaEpJqc
         tAqloQLgo+0leY2+jcX7BctXRKEu1Dh7XonDhnekQNcwPj3eSmmt35tYBh9dVRaYXXd+
         Dbs0RchRnxl6Wu0TvCV+eY+xUG8X+5DOMxgkTy3qxZf0QtHYDGMiNiG9a3U6UOZ86tgn
         HT6nECDSJcrXeYwha2G0ohScjJhSY1U5T9P5s187qNYRFkSiVRmdIlvkPFf6r1ohpMqo
         AjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702508386; x=1703113186;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNCEG9XLO18BtpVTafkinlcABzPXAnc1ejK5b0Uz2xE=;
        b=U/ZoY9Jt06cLkv1LYbg6wVDb2rIDDevh64sArFIFUYI9pUMwFkVJnC23h7WMqcNCNp
         9SYQkBz1SnNid+lUC0G78Ni47AI4nlX8kC/zwiI24E5ts8IaWX+/qXxgBt6icw3gZPJF
         43WgZ1Lxrogh8foIym+y+wmqhdhOaIpGNsogoyEGu2U6+FxP0JOxgEdH37kFtzGYtzV+
         7ekOVztJJYUF7xHMetKJrZ5A1/ImAO6BiqeA6F1ChopZ5HW5Jp9stqg1TRg5L+hQifgE
         ctt3C0nL3b+U8e4S3ttppCJWDWdKdEWqh1m9Z5CBMB20EfRY/A+IJMvUAtVJ+/Df77nE
         /DVg==
X-Gm-Message-State: AOJu0Yyo+n83hgnMVvJ5qgTSls6EY/5VDwmG+Fx7WM4TqnLYawOwFJaj
	ZKvcNu0vrpoHmC0xN91/Roo=
X-Google-Smtp-Source: AGHT+IFy3n6hQ+XnZsJgquyeVxyUxf64OBB1xP6YIp2bcaJQGW32QIWv6NLcWyoLLLQY0bybEtJ+xA==
X-Received: by 2002:a05:6870:b48e:b0:1fa:fadc:4d1d with SMTP id y14-20020a056870b48e00b001fafadc4d1dmr10389360oap.53.1702508385963;
        Wed, 13 Dec 2023 14:59:45 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id lb9-20020a056871414900b002032ace6adasm434442oab.14.2023.12.13.14.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 14:59:45 -0800 (PST)
Message-ID: <a269538b-9c6f-4646-8294-c93ecd06475b@gmail.com>
Date: Wed, 13 Dec 2023 16:59:44 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] Fix extra settings not being taken post-DPP
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231213172546.145998-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20231213172546.145998-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/13/23 11:25, James Prestwood wrote:
> The current logic in DPP syncs the settings to disk but this doesn't
> actually turn an existing network object into a known network, i.e.
> sets network->info, which then allows settings to be loaded from
> disk via the open() op. Currently a connection can be made (since the
> PSK is set into the network object) but any additional settings like
> Hidden/SendHostname are not used.

Okay.  So you can solve this in two ways:

1. Have dpp listen to KNOWN_NETWORKS_EVENT_ADDED and start the connection once 
the new network has been detected.
2. Fix match_known_network to take care of merging the new settings with the 
temporary settings obtained from the agent / set using network_set_*.

Advantage of 2 is that you'd be fixing the current race condition that exists 
today, where if the connection is started and a profile is modified while the 
connection is ongoing, the new settings are not taken into account.

> 
> This set is one way we could solve it, though its a bit intrusive
> and requires DPP have deeper knowledge that it really should
> regarding known networks. It basically forces the creation of a
> known network, and I did have to modify __network_info_init to set
> the default ops structure, which was a bit nasty. This is the most
> direct route without having to worry about callbacks and/or idle
> functions.
> 
> An alternative way would be to watch the known networks events from
> DPP and connect only after an ADDED event. The reason I didn't go
> this route was because I wasn't sure about the event ordering. We
> need the watch in network.c to be called first (so the network->info
> can be created), then connect from DPP. watchlist_add does append to

Just use l_idle

> the tail of the queue so in theory as the above _should_ work so long
> as the network watch is added prior to DPP, which is the case since
> network's is added in init versus DPP. But I'd hate to put an implied
> dependency on watchlist ordering if this changes later. This could
> be coupled with an l_idle to avoid the watchlist ordering, but thats
> yet another callback.
> 

Regards,
-Denis

