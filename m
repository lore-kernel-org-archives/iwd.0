Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F545381
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 21:24:22 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1319cf91d8aso4984940fac.5
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ez6ugENM29ENFtSIZuVG2+HyrtJlmMNjBa2cd+tADrQ=;
        b=gE+LSDKU3U1Y0Cu1bJGvXMNRxXdw8Iaqszi7bCuJyD+QF8i3O/h/+nqv3325fHEyNl
         /TUZoXLXhOzDl4iUUTNpK4BOezUIf5NuobRmy/wKw1yuK2lAecZcpNUo0gCNhBIFvu6W
         OQIo8znL7+eEr7nz0Bk0Uru3B67xEdF4O5AWIW1JpZaf8687nAaDFdjuvSYpsnF9GXjT
         TpNOCPdL45ufY5nbd7uGBS3U8IO1r2GhvwAquDMK2YbZHGXTdMseMxEUwWhv3aE6DdfS
         jOpYq7Z4qZwCTQIlIrNkmyQQLRbVBzI0ipPwmcMCIbh4BjgFC00N+m1IDM1DKFEOBi5D
         YmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ez6ugENM29ENFtSIZuVG2+HyrtJlmMNjBa2cd+tADrQ=;
        b=4W91dB3zX7D3uD4BFkCa3E7bGHpbwNpuqqeRY+GXylqsOVSxraULt05PGQXa0MRGS8
         uojUetuZNU2So+vTV8j4Ej0iDlNqim5T/14XXeVteHwNgwAlY0g5Py3aJnu10OFZcut+
         Dkc/WJ09f6shhWPhWz51K353YhuYOJe0AAUCrziN763ERoqM3AO6NCdq19gXg1YDht3h
         OSrbMlf7I3LuEIkeTw6BpFs0lXVe8TCcPDVdGLHbuuTuuRknprCDOyTUfEyyYZB2OWSU
         2m6JTneCIx7LpTAbf+GqB5yQGNkewVZ0Jm1O9OrPyFbriWvCkGA/Go7vi3kJDP+MBSWx
         J85A==
X-Gm-Message-State: ACrzQf2IMjHU/vfM3wFpgRQPWrEwLNAvUQqu8gj+1KNWMRkPUtsBrk6M
	+91ZDrRFFxGD1wy7Km5d+Vc=
X-Google-Smtp-Source: AMsMyM4aXnW+m1U7Q4mi59iOg5hy1Zp0pyH2rKFzT1GraSbqvCK8MOh8Dq5S7tJH8rpSatNcYU0Qew==
X-Received: by 2002:a05:6870:340a:b0:127:74a9:c8d2 with SMTP id g10-20020a056870340a00b0012774a9c8d2mr6615641oah.235.1664400261645;
        Wed, 28 Sep 2022 14:24:21 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id w13-20020a4a978d000000b004761ac650e1sm2329212ooi.42.2022.09.28.14.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 14:24:21 -0700 (PDT)
Message-ID: <74ae7449-7255-cdf3-c471-f3bd559fd0aa@gmail.com>
Date: Wed, 28 Sep 2022 16:24:20 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] wiphy: add wiphy_supports_probe_resp_offload
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220928194852.375786-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220928194852.375786-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/28/22 14:48, James Prestwood wrote:
> Parse the AP probe response offload attribute during the dump. If
> set this indicates the driver expects the probe response attribute
> to be included with START_AP.
> ---
>   src/wiphy.c | 9 +++++++++
>   src/wiphy.h | 1 +
>   2 files changed, 10 insertions(+)
> 

Both applied, thanks.

Regards,
-Denis

