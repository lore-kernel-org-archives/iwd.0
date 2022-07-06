Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC6539A
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 17:57:12 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso6215906pjj.5
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=b3jiqIYB+ajPZcvmR9bdGas46zPacJ4DUypF9L12fNw=;
        b=QIJMLfRiY20C66vOlzhqd/ypJNu9ZgIbL84a8Oloz1D2RQ3ZfecFWxjcCO8WcB6G/c
         oiZHL2EYKM0VDrdSivCrA/9t4jcWJbtTv9NJ4F+97eowMa3dUEz8WgGrxWTOLYtrozQk
         kQnONKPB33sjdl/faWWFs3Q9d/HCwCPMsintBvvt0ysREGRabKwoYx+HcciwTt3NuHuV
         mPnO8jMI6YyONafV8mP9skI6uPyuKhJCC0eCijIQRX7gfNU+myrMpVRpV5JEnrr+7Yjl
         jbpsAmndjhkkIWn18n8/rJm1Y91nj6CBney9FbQJi0jZsNLcuf06zqnP+OSrplbR8jX1
         vgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=b3jiqIYB+ajPZcvmR9bdGas46zPacJ4DUypF9L12fNw=;
        b=6uFRDFoOPpuWa2/hPL1MUw4T1Y7vR6cVlFJX2LkvkaBQUI8iNMPoZUraqrWxG54E/N
         YFKbWypRw/HWwoL9HZS12rfFR4KLClFdLo/WISwJExy6nAJFvj62wgh+GhnxmsD2WTkQ
         9luOLNHlvThqIL/7G2B7BO4UD9+sz1aWf090YgzzJewJkyVXAVOUw//gLdbriNHmNB3P
         r+gWGOvGLvhjUnDSoKyTxnHEeDnlLxJxOnGwGUsq8fOzuTNN6OnEL2k5iisWjSz617Od
         L1of0AiEXPppqr2r6KofRTVUhiN23WexeBEt4cn/xc8/IojJtFPku2j+GIJN4bFNUOS1
         a6xg==
X-Gm-Message-State: AJIora+Wv5fJbbBcu6lMgz7kRq0TnmTmb/PdiNyTk6yvigk0ZB0RQ7XM
	/uhNFIC5T0Fo+K7Q1qh1oZ9lDACqMs8=
X-Google-Smtp-Source: AGRyM1sUwOV5s69iTzqO4CxNIWSwnT6+cnzmcwwgy6YA5PozM/1p7+I3JLLdolsOIucGIOtLpBVlsQ==
X-Received: by 2002:a17:903:2290:b0:16b:f082:f4c2 with SMTP id b16-20020a170903229000b0016bf082f4c2mr11128007plh.140.1657130232484;
        Wed, 06 Jul 2022 10:57:12 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y11-20020a63de4b000000b0040c644e82efsm24169989pgi.43.2022.07.06.10.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:57:12 -0700 (PDT)
Message-ID: <284b6456a09905fe55486f9a829f5fc84ac3cf39.camel@gmail.com>
Subject: Re: [PATCH 1/5] test-runner: Support running hostapd in namespaces
From: James Prestwood <prestwoj@gmail.com>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
Date: Wed, 06 Jul 2022 10:57:11 -0700
In-Reply-To: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
References: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

On Wed, 2022-07-06 at 18:56 +0200, Andrew Zaborowski wrote:
> The kernel will not let us test some scenarios of communication between
> two hwsim radios (e.g. STA and AP) if they're in the same net
> namespace.
> For example, when connected, you can't add normal IPv4 subnet routes
> for
> the same subnet on two different interfaces in one namespace (you'd
> either get an EEXIST or you'd replace the other route), you can set
> different metrics on the routes but that won't fix IP routing.  For
> testNetconfig the result is that communication works for DHCP before we
> get the inital lease but renewals won't work because they're unicast.
> Allow hostapd to run on a radio that has been moved to a different
> namespace in hw.conf so we don't have to work around these issues.
> ---
>  tools/run-tests | 80 +++++++++++++++++++++++++++++++------------------
>  tools/utils.py  |  2 +-
>  2 files changed, 52 insertions(+), 30 deletions(-)
> 

<snip>

Looks like this broke testEAD (or at least this is the most likely
patch). gitlint also wasn't happy but to be fair I just copied the
bluez config so I may need to take a look at that.

https://patchwork.kernel.org/project/iwd/patch/20220706165702.3241756-1-andrew.zaborowski@intel.com/

I'll go ahead and add you to the maintainers list so you get the CI
notifications.

