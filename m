Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ADEBD10
	for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 22:32:11 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id r130so13941544oih.2
        for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 14:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AzwJDkSiFwAO9ERhZk7urik0WdEjPBomb5Uyvcf5tjs=;
        b=qlQTyCnYqHxDi4bo/sUQGdpEEyuXDrxmrXMsT1rtuOTgyIrZezebnNXNRJOPT1iPHA
         Jb8g3Ay9eEekAPdsKgeMgKt6ef3XED18uxhIU+5pn6TlLKmo9Ev7JINV+t0bMbW22l5d
         Bmh5VezbvwX9SITU6cwJzL3EhOSbzSylrsQuq3tB4B6CwZA+SBmTRiQSK18u35emSf0V
         5n6pIZ35kFNj3YQSlLNw9fXGSZ2BL4gOTJnlW6yY2RoSFXBnD9bFXdqGXhRL7CChP6yA
         AfekK77sBdkhKEv2D8h2x3p09zaOtoIKoK91fAtNycGfc4KjDgHsG1KhLNpr4/Vc5mj1
         PyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzwJDkSiFwAO9ERhZk7urik0WdEjPBomb5Uyvcf5tjs=;
        b=vObPglapdvwnra7UVMKxnmkh5CYOq4ybBsGKduh8Vlb+E24umn29nIruea8J+hG9YE
         zpK4DUsWMC5WPRN+7jGJduoPfoFnLFlyP/b8rhxltvc5HQC0uzEpYEuRQCCadoLH43pt
         4jOeTclwAa4r1ecQX0yzXzNfc1FAjTkFloBhV53bRSdPSBIRX/FjR5U21O8Y4cP9Xi69
         aVc9I/ilk5Ta40A4kACaxPuJznOESAp6nXEYd0sxrcxkA5xR72rbWxxgF4bbCyaMPs04
         tJvrKQM7gcoybPng9aUxHBF/wHcw0KYJkLrLRHz5UZrU+6BnnrZ7Px8wdmDUhS8FAUoY
         2t8Q==
X-Gm-Message-State: AFqh2kqm9s8DLJ69tclIMbKHqw32Lz0LLA1Z89LZwehgbSprR3cfX6cY
	r1hwDDa+1sksWroGM6i8J19RLUUSYeo=
X-Google-Smtp-Source: AMrXdXu2PoUeSRmwxluq0NfRgYZRdwjTadUbeJ7WZAfKztRWa7in2caBVW/jxOabNoy8Aq713YS0eQ==
X-Received: by 2002:a05:6808:2095:b0:35e:7acb:603c with SMTP id s21-20020a056808209500b0035e7acb603cmr42095720oiw.27.1673476330533;
        Wed, 11 Jan 2023 14:32:10 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cp17-20020a056830661100b00670763270fcsm8309279otb.71.2023.01.11.14.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 14:32:09 -0800 (PST)
Message-ID: <8c52cf9b-a4e0-2875-7dd5-12907fb1f496@gmail.com>
Date: Wed, 11 Jan 2023 16:30:52 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/9] handshake: add event for rekey success
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230111201543.397692-1-prestwoj@gmail.com>
 <20230111201543.397692-4-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230111201543.397692-4-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/11/23 14:15, James Prestwood wrote:
> Rekeys for station mode don't need to know when complete since
> there is nothing to do once done. AP mode on the other hand needs
> to know if the rekey was successful in order to reset/set the next
> rekey timer.
> ---
>   src/handshake.h | 1 +
>   src/station.c   | 1 +
>   2 files changed, 2 insertions(+)
> 

Patches 4-7 applied, thanks.

Regards,
-Denis

