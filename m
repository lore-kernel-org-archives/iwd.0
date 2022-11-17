Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7C6AAA
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 16:29:25 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id a7-20020a056830008700b0066c82848060so1367715oto.4
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tf2Z2OSjEGQn3vaaM1vufndS8MMlNcVVIXDxcjIyH1Y=;
        b=aTCEBcAlUp5XFod6KaRB451WsYdFs+456Z8FvIK914EfgafBKLgZ+U8PCM2yUrcJxh
         eYyz1s8Fc16EnT2SfZElj6Cul+RXlQc0Qb1jhbvcpkjQr6mGTd3j2yj7WmbjOk7iRzQG
         jU2J1/e5AJMvZFNNsM9GsEuM+tr4edXILkUHdT3KfMreImnjldGjIRqp5Y+SxP93YQNl
         /97h/G2cuNSiYPPaVh1ZvywblQ+FCMlyPloRgEiBNLNHtH94y/oY+07epu1PAyo7JMJg
         jWETj0ZroDRntzrO2B898avNd3RGxHZygKip0fHNQztVXFUnHTZXIxvbHUyD2+IxkQ0n
         pX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tf2Z2OSjEGQn3vaaM1vufndS8MMlNcVVIXDxcjIyH1Y=;
        b=Gqme48uVrGaJ/k0x6pkgwI7ebdiIPmxi9P5ung2YkhSPHJS+7pcb88hsF19QktACij
         FxouBsxSTVnrS4yMYSZma0K/+u9NxABkZjqPPRyl+MaSQgscG8qPCRfCMQbvs+sm74I/
         jJi0i6GsxaTTPFVoacxa2+Ghx5VKTH/BQYwVEzYmadCHfFjGFnfDII6Rfpz7mW7lb6Xz
         xRR6EiHhrKvlysCQ2dPPgecY2K3eC/muifyR4NW4hPGy+0qj12aV2pyv62kHsC6N3rjc
         /3KND0dTPx7QUs2J2OOrt2PcpjoqL4zBG4135kX4oOHsEzuZHCq/WnICGUtiVVUBjHg3
         7rkg==
X-Gm-Message-State: ANoB5pmLmqTAw3cqZWNSzRp6CpUrXL5rgpK55j1qKLsvT83x1z4nFMX8
	wvYBs77nKBo0taqWTlX5Y7c=
X-Google-Smtp-Source: AA0mqf6DupLR2bPHPrcd5fFs/NY7tM953dBPBfRHW6chLo775JBEPxFFNbAyXzmDegaEcsF70U6gfw==
X-Received: by 2002:a9d:77c3:0:b0:66d:b749:803c with SMTP id w3-20020a9d77c3000000b0066db749803cmr1830466otl.117.1668702564616;
        Thu, 17 Nov 2022 08:29:24 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v12-20020a4ae6cc000000b0049fbd80e522sm343562oot.23.2022.11.17.08.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 08:29:23 -0800 (PST)
Message-ID: <878e8c89-6754-af3b-6d2d-9195a920d728@gmail.com>
Date: Thu, 17 Nov 2022 10:29:22 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scan: make scan requests fail if trigger returns -EBUSY
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>, iwd@lists.linux.dev
Cc: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>
References: <20221117152155.2310412-1-alvin@pqrs.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221117152155.2310412-1-alvin@pqrs.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alvin,

On 11/17/22 09:21, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> If a CMD_TRIGGER_SCAN request fails with -EBUSY, iwd currently assumes
> that a scan is ongoing on the underlying wdev and will retry the same
> command when that scan is complete. It gets notified of that completion
> via the scan_notify() function, and kicks the scan logic to try again.
> 
> However, if there is another wdev on the same wiphy and that wdev has a
> scan request in flight, the kernel will also return -EBUSY. In other
> words, only one scan request per wiphy is permitted.

This should really not be possible since all scans go through the wiphy work queue?

> 
> As an example, the brcmfmac driver can create an AP interface on the
> same wiphy as the default station interface, and scans can be triggered
> on that AP interface.

Or are you setting up a second interface out of iwd's control?

> 
> If -EBUSY is returned because another wdev is scanning, then iwd won't
> know when it can retry the original trigger request because the relevant
> netlink event will arrive on a different wdev. Indeed, if no scan
> context exists for that other wdev, then scan_notify will return early
> and the scan logic will stall indefinitely.

So I think the way to handle this is to make scan aware of all interfaces, even 
foreign ones, and consider restarting a scan request whenever a scan finished 
notification on a given phy is received.

> 
>  From a user perspective, this leads to a situation where iwd reports
> over DBus that it is not scanning, but it never queues up another
> periodic scan. Or if a scan was explicitly requested over DBus and the
> trigger for that scan ended in an -EBUSY for the aforementioned reason,
> the DBus method call stall indefinitely.
> 
> Since scan contexts are handled on a per-wdev basis, and since multiple
> wdevs may in principle share the same wiphy, solve the above problem by
> instead having the scan module simply propagate the -EBUSY error. In
> practice this will mean that scans may fail more often, in which case at
> least one default error message will be logged each time:

I doubt this is a good idea unless you want to visit every call site that 
invokes the scan logic and make it handle -EBUSY gracefully, since it is a bit 
of a special case.

Regards,
-Denis
