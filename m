Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01B79E2
	for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 17:20:41 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id h132so12099294oif.2
        for <iwd@lists.linux.dev>; Mon, 14 Nov 2022 09:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFKImKpH9HnW/48c2VvY9FGBFFpj0mKNT7vnBAB7OMs=;
        b=MV1QubdiCDCHqYNt5GvwPgESE2mXYbQHsyW+oRL8lC1Is842Cjw34t7m/1ilhc9EOt
         TMojU3fKNrOZNFacKI+lthLuUhDZ3SGnwPjgm01aYKMEefe6RPqd0yknkFn0Ce4PMhzY
         FZ7LrzJlu2Qzgob5lH5FmffPDc10LS+lR8ojRVaXzasqav9ie4uaqbbb6n4SaZ9bAWBT
         SsWAkFPMH3Xgm4XLuBpD4xj7yoRlmNjPvXT2zcEDuZjQfAm27niytUKRfz3HPFXXuSL7
         yc+HGHBXAeBdZAyP8wRusiyyYGCCS1mj97WMzWkjEISmmKTI0WBWQ7foyce+Xw0Cv0Iv
         ahQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFKImKpH9HnW/48c2VvY9FGBFFpj0mKNT7vnBAB7OMs=;
        b=QZ21Ju3s7JJd9H1kMCb8K6KwKqAUQubl4SkCuRYXRz4mKS5SKRY9kNY6DU1Zh9274c
         X+Ghk7DGTRF+AUTdVmwZOaq78KzwvYP34CFekNanPKT/S2PL2xl2fpSSBpeAU0reeYLw
         ZXyrD4aogbcsVNyQlazdkWFKnDkRGSDA6z6lh6DxBNGU1/ReuZwW5kFZOtpXPQouGuW7
         nH2LCeXWv86nQFgNlaT162Lpmvx1lpnY6b0P2d72QcMPtaT3gqNd3eRT18vxwN69MEoo
         kzMnFc1dHOscR2y0An7OHeAtgMC4DSQJtQNRYUnUj7smhqM452JaC6RDyXV1ahsVSfDk
         2lqg==
X-Gm-Message-State: ANoB5pmoidoT9gVvQVTA7/xQUM5yw9605ACw/VOdVnxtPOLdWKaufOTt
	tBcCmuQ7oai9V18NVT4TDUNHXHqhfmw=
X-Google-Smtp-Source: AA0mqf71kWISFxguxtVlhYjML06OzQ217bv0YcLzzmcLAE4Jhvp/0ffpssiaSQ4rjKPDegtKRB1BEQ==
X-Received: by 2002:a05:6808:208f:b0:35a:388c:7452 with SMTP id s15-20020a056808208f00b0035a388c7452mr6258035oiw.72.1668446440918;
        Mon, 14 Nov 2022 09:20:40 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s5-20020a4adb85000000b00499527def25sm3808846oou.47.2022.11.14.09.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 09:20:40 -0800 (PST)
Message-ID: <dae74530-3fa3-0507-1d53-928d8cbce757@gmail.com>
Date: Mon, 14 Nov 2022 11:20:39 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Scanning hangs up with Marvell wifi card
Content-Language: en-US
To: =?UTF-8?Q?Jonas_Dre=c3=9fler?= <verdre@v0yd.nl>, iwd@lists.linux.dev
References: <1e372397-d06d-df32-dda3-d89a580a9ee7@v0yd.nl>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <1e372397-d06d-df32-dda3-d89a580a9ee7@v0yd.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonas,

On 11/14/22 10:18, Jonas Dreßler wrote:
> Hi everyone,
> 
> iwd is having trouble scanning for me, it seems that any subsequent scan after
> the first one never finishes. A quick round of debugging tells it's worked
> around by adding at least 100ms of sleep before queuing the second scan with
> station_dbus_scan_subset() here:
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/station.c#n3886
> 

If the hardware indeed has trouble with scans that are performed in rapid 
succession, then your workaround will just address this one particular symptom. 
  The scanning logic is quite complex and there are lots of scenarios that 
trigger multiple scan requests one after another (periodic scans with lots of 
known hidden networks for example).

> I'm using a Marvell wifi card with fullmac driver that is known to have a ton of
> issues, so I'm assuming it doesn't like seeing scan requests very quickly after
> finishing a scan?

No idea?  You might want to post logs or iwmon trace.  See 
https://iwd.wiki.kernel.org/debugging

Regards,
-Denis
