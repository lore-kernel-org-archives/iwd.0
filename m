Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E044C8C
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 21:09:59 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id m81so2116676oia.1
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=51K2caaOVYM2u6BJO2aP33+rLDyHi14FiBSfTFX5FHU=;
        b=alpIwA8c/LdV/Lb3dLZSn6DIyohH5ogWNzYGz4MWzrsqC5p7NZ3U7xrGVskFZGEGWQ
         k3na2uJTinUCt7njnEsjKQQRlUHbrabYKPTq/0AMgjxkXQoSLE7Fbe6/ZY2K7BRmM8vY
         3uzpMGTgv7woiGxSO7pYZyQGi4zsMl6kAiazmrH0NxtB8vIovIKYW5AKVWcrDxnpVS3t
         H8pq0bsep6CMxARemRjLzaJyAf/So9DCxTjjG16w1Fs+immAZ2Yls8x/AeYmosIgPuwK
         sOzW4K32IV+CplGiZ52c74QLjrpaEnwzi9hV8DOavmSubOTuEFpxhs0r7tdDR7OjixX2
         vhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=51K2caaOVYM2u6BJO2aP33+rLDyHi14FiBSfTFX5FHU=;
        b=ccPGZ9sHE22Gg46NV//tYWXZVX1FZqdM9kbffcRGYRGhJzRXYWMTFL7PgqIJMeNLnU
         QfaazYHR2idERYVdm2f/CXfC4hoaB4COmBQRAJ6UTCXtz+J6Q9ZEHWb+gWIPxAKZqepp
         ylZgc4OM+1belAKItmTczfcYgzfsQF5t0lj+rtr8ArlafW0cgmkpNb9toQ+qqn0DrZno
         Xsr9PtnQQ/KdeCydZeaTXOyFcKTrHsd8u24s4Z3PMZrH/LrY5hbyejtpe4w6zjqSbCN3
         c2pTwovAu0cmXqjQae/hcbEe+StaYUnWLNxTRphnNxW1eqrBAp3cDM8Xb88A2TE4DJSx
         DxwQ==
X-Gm-Message-State: ACgBeo2M2f/EM74bdsEG2V6/fqJK7EJQr7GID5nz2J3+b8QM20BFsLvv
	Htg1VmkbVTlw3PVSP4l1q38=
X-Google-Smtp-Source: AA6agR7siR4TRF/+iqKCipKPXjDYEQsNUdsUTpOXPik+7sn+/bl1lHI8Cxx95ylgLHcfU8tk5Uf0FA==
X-Received: by 2002:a05:6808:a19:b0:34f:d8d0:260 with SMTP id n25-20020a0568080a1900b0034fd8d00260mr5398524oij.166.1663276198699;
        Thu, 15 Sep 2022 14:09:58 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id fo16-20020a0568709a1000b001273c4097a4sm2004189oab.17.2022.09.15.14.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 14:09:58 -0700 (PDT)
Message-ID: <4099c298-be28-8a9a-d1af-c86c7134aa0e@gmail.com>
Date: Thu, 15 Sep 2022 15:49:22 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] station: scan before a forced roam
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220914155413.748576-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220914155413.748576-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/14/22 10:54, James Prestwood wrote:
> This will make the debug API more robust as well as fix issues
> certain drivers have when trying to roam. Some of these drivers
> may flush scan results after CMD_CONNECT which results in -ENOENT
> when trying to roam with CMD_AUTHENTICATE unless you rescan
> explicitly.
> 
> Now this will be taken care of automatically and station will first
> scan for the BSS (or full scan if not already in results) and
> attempt to roam once the BSS is seen in a fresh scan.
> 
> The logic to replace the old BSS object was factored out into its
> own function to be shared by the non-debug roam scan. It was also
> simplified to just update the network since this will remove the
> old BSS if it exists.
> ---
>   src/station.c | 143 +++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 124 insertions(+), 19 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

