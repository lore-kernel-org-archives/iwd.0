Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC87C
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 20:43:30 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id w20so6817753ply.12
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=jcGE2YunC+nZTDCdaIkoo5K6d4GRFXhLaRWlIk46t+w=;
        b=M+myPj9WfR8WNUoX14+qWdTwVJ+XQVf3RpHDEzkS+j+OFGGAbE+eN+uljgf7NHs2/w
         TNgeHR7qJ4t4BwjcV6QIJhNl3L3MAVL5UrTbT67FHkWlFLzwtfwYTtv79/qVICX547KA
         kQwh7CfdaivenM/zT0vpuotx+uZkc0yX3U0AeOIsz3y3eUzhQkgQltubbkv76pMV3a8F
         UsSYvLFnVLxypw+g3UkvdxFzryoK+qvu+x2/zgm39NqW7a5CRFFfLRPmM0vOcNIwcUXd
         3WGtUzKYTE9Wbsf8Yfn0tO2NJL+KBpHWJjLCmRt4czfJ/snxYvTn/IL296K+YNC/YTh1
         SN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=jcGE2YunC+nZTDCdaIkoo5K6d4GRFXhLaRWlIk46t+w=;
        b=uw9kfCsclGulRjlFki6P9dnc1d8ikeXyN8HzeYv4JbHFQfhm7ICqtgGtQxNbnsKowQ
         gsgV0YsAGy9QdM8RHpuT5ON3xIYCuU0p7qfNBvVXlKOZkDaaOqBhEN41KPxzbbjdB0EN
         aN96eKR95slDE5VqY1AMAi5zzab3KEzpXN2Gc+ue0fCCCZPbDaaI9Kk1mmOR+TYz7Nls
         WQOiRDcglCDwBd4QvUm0Mk6slBFLaHog5FB6B6GbCRNJXCP4pZLTOEW1WlqYdlynMBW4
         7nVTZRbX8Wwa0gP071KFSV/U3e5/x+NMAZPv0Oik4H2G3uwTuBHAhLPBt+IzWXXOQKr1
         V8uQ==
X-Gm-Message-State: ACrzQf2P6+BDOwvZzU1MG0OXhj9+S4h86H5UBWiUO1tvgO63Sh/KXfYa
	OYoS1xe5jbeNfYB12Iopq8w=
X-Google-Smtp-Source: AMsMyM7cr58Aqj2v0Wzk6L/pdtOWw37mwbasQMSDxmWNmE8VvgMTFmtnJoNKolOsPC/SNsMYoe1G0w==
X-Received: by 2002:a17:90a:f990:b0:203:b20:ffe9 with SMTP id cq16-20020a17090af99000b002030b20ffe9mr55301pjb.48.1663793010068;
        Wed, 21 Sep 2022 13:43:30 -0700 (PDT)
Received: from [192.168.68.95] ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a16c800b001f30b100e04sm2327002pje.15.2022.09.21.13.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 13:43:29 -0700 (PDT)
Message-ID: <77f95956dde70bfa43376b9e36430f5a14c71ee4.camel@gmail.com>
Subject: Re: wiphy_estimate_data_rate() failed
From: James Prestwood <prestwoj@gmail.com>
To: "Johnson, Bryce" <Bryce.Johnson@landisgyr.com>, "iwd@lists.linux.dev"
	 <iwd@lists.linux.dev>
Date: Wed, 21 Sep 2022 13:43:29 -0700
In-Reply-To: <AS8PR01MB74931FD1507D2D70FDFB5F05F44F9@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
References: 
	<AS8PR01MB74931FD1507D2D70FDFB5F05F44F9@AS8PR01MB7493.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2022-09-21 at 20:04 +0000, Johnson, Bryce wrote:
> Hi all,
> I recently updated to use IWD 1.30.  I also recently added a script
> to call `iwctl station wlan0 scan` and then `iwctl station wlan0 get-
> networks rssi-dbms` to write out to a log file every minute for
> debugging.  When I went to check my iwd log I noticed it was filled
> up with wiphy_estimate_data_rate() failed errors.

This isn't a fatal error, just a warning. It means IWD couldn't parse
either HE/VHT/HT or basic rates from the scan results. This just means
that BSS gets a very low rank.

> 
> I stopped my scan script and manually called `iwctl station wlan0
> scan` and was able to cause the error.    I did also get a deauth
> event around that time when I was looking at it, but not sure what
> caused that.
> 
> Received Deauthentication event, reason: 4, from_ap: false

The above warning definitely won't cause a disconnect.

> 
> 
> I restarted my device, but I haven't seen the problem happen again. 
> I was going to start IWD in debug mode to get more information. 
> Anything else to capture if I see the issue?

It is probably a network around you that isn't yours and IWD's quick
scan isn't seeing it. You'll probably see it if you do a full scan
again.

> 
> Thanks
> Bryce
> 


