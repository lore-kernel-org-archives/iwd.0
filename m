Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9F4A11
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 17:34:44 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-131886d366cso6551988fac.10
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ka7qvSB4l/4lEcqQDo8vU+PSjeJhCYYYbd+1vpaTYcE=;
        b=SFU1GRIZdaAYdg9qDSXoSx8vu98OTtO8pY3mYRg3SEjfa55Tz6FGsj1PWl7vGVGWrC
         FKbElyvG1zeGVpn5tiwbrOav2S2waRP2xHP6Mf/cm/h5I38rUxHeBrfue1e8l+mwEiux
         ae+W6u8VWjgm6lr0vKmVR489KynaFDjbeD/mN1hNHdcmUTO+vI3wlMbPNLE4aTOhNWv7
         7TWbY7kPBsBhRpnPVGKO/lPC/KYhtSPuTU3WCtCWPz1Ghg4mCNN7qzuPYkmuq+gdt8bD
         fs0SyRULGQqi6jREyBXGG8lpv97hH2YNPmkyoHmH9Y65P5++2BLdTvAa6le2DhADDBe5
         DqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ka7qvSB4l/4lEcqQDo8vU+PSjeJhCYYYbd+1vpaTYcE=;
        b=gAtFtW7dhi6BcPqEZh9FAPkjdKJFNeiNENYFvOMKy47daXZOnGmZ1YAHyWOHzkf753
         2OlSR6skllqVIFm7biYMfWwVGU369r8eUxv/fsLQdbg1hEEtKn0nNqtUWuXFQqq3UpOk
         6d8d+D9qYhwv+qPIRH9oiUKlSZXiQR9kK5YHOINTU+ZShHUtblELfEAOPisl23lyfQ58
         HE5vO/mVjAGC4X/Y3dgDKg/LzgR4fqYESzXBp6gXNNz2Wqf/FMpeH4ZdX1mcJfwLBboO
         0W3C1ufJ4f93446HwJePqB4X/3P4CHpImrhPKl1UqItMWjk1XM5VOhqhyoqiYeOomcOi
         d3gA==
X-Gm-Message-State: ACrzQf2+NADrt6FR0wxHxx+963bAbgiWwctJ2TtLNHaKyxh90eSPuiME
	8QHY2XiO103U1+pUXNYDm/Y=
X-Google-Smtp-Source: AMsMyM6s6RW3nO91qQg5PizPT45xFitLoi8zKvH2zt/oMoPtwxKD15Kq5db+dsQmrxh1WHjsCBKa+Q==
X-Received: by 2002:a05:6871:893:b0:131:84aa:5b80 with SMTP id r19-20020a056871089300b0013184aa5b80mr5590824oaq.257.1664386483437;
        Wed, 28 Sep 2022 10:34:43 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m7-20020a4a9507000000b00475f26931c8sm2175662ooi.13.2022.09.28.10.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:34:42 -0700 (PDT)
Message-ID: <fd7c11cd-3389-dcf3-e8d7-d4f29ca6b250@gmail.com>
Date: Wed, 28 Sep 2022 12:34:41 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] station: handle ROAMING state in disconnect event
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220927231549.310800-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220927231549.310800-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/27/22 18:15, James Prestwood wrote:
> This both adds proper handling to the new roaming logic and fixes
> a potential bug with firmware roams.
> 
> The new way roaming works doesn't use a connect callback. This
> means that any disconnect event or call to netdev_connect_failed
> will result in the event handler being called, where before the
> connect callback would. This means we need to handle the ROAMING
> state in the station disconnect event so IWD properly disassociates
> and station goes out of ROAMING.
> 
> With firmware roams netdev gets an event which transitions station
> into ROAMING. Then netdev issues GET_SCAN. During this time a
> disconnect event could come in which would end up in
> station_disconnect_event since there is no connect callback. This
> needs to be handled the same and let IWD transition out of the
> ROAMING state.
> ---
>   src/station.c | 1 +
>   1 file changed, 1 insertion(+)
> 

All applied, thanks.

Regards,
-Denis

