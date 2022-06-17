Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBB20E1
	for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 19:07:38 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1016409cf0bso6617158fac.12
        for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=lrYLFEHjtrx73DspDm5vdyU2JOjm40wdbnDxa1rChUs=;
        b=G8XTgVTLPSY2ftXdAhkB0vw+C/5cXgVI437TbPOZOuX4vs0GV8ZVPl7w5EgOIqQzC6
         veWPoiEIF8PMjyryLRQ2ByUUK+Pw6NcDQOSAAuJqrR94t84Dc7GfNmzfsF3JlzLiJorE
         n54znmm0xamjacMUQ9dokBUU3IT09sK92+ivN2mHGwjyLVwSGCMJdlfTIQM/1dmICamQ
         pGjgqzJqAX0OcHpl6sbfrr2cS3L+BipsWOkgP3NDORCPG6LR8F7t8yMsJhwVZJ4FB+Jy
         3pwmqqxrBozdJXVu510kTu3k4BYbqUwa6lf3bpNwkIXivGFbpMBhTbVx3x+A/g9FG88C
         F2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lrYLFEHjtrx73DspDm5vdyU2JOjm40wdbnDxa1rChUs=;
        b=FHHPiDBWv34kOjlnS7Ee5GJsqObnP8eIjmoFPvmvPLDdL3VJFEcNyrJ6CvdJnlG4LQ
         W9vScX4DQ4W95vhOShGREEuyL5xyiLeQjPRAyjBT3NHDwTQcE22YjBV3ZtkBoMJYGfYg
         7HjMcdpFMlugArQe2JXPGlkZD/eNveLojuAhSApm+Dw07B70qKT7L6TxQrYpD7nIcXeI
         NSUV9c4V4IGryXB83pUAmAkuD266QdnAJIgl+/VgMzcjd2EHcG9B8mDeZCQQw2t+ED9E
         ikE+tw24YzzO2mRYeUT80993JL6wgbEvkLe8RaAo8MZakMDhmpsvx1Zt7YfCqHX53HIb
         GZLQ==
X-Gm-Message-State: AJIora+yOfnn/c+SHqc4/MAmW12cPZOmRVrvT8v33v4MFeGoscjS0sg4
	Rdh07NM/u1Wx/gGrhtlClcA=
X-Google-Smtp-Source: AGRyM1sKWxdTtltycvA8HqCQUbUh/VTs+t7QpZtOecmNfKGGqGaynXgxBRx/u8TDboEXRBni+zdqvg==
X-Received: by 2002:a05:6870:2499:b0:101:7531:c7ec with SMTP id s25-20020a056870249900b001017531c7ecmr8089306oaq.42.1655492858021;
        Fri, 17 Jun 2022 12:07:38 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id j20-20020a056870d45400b000f5e256494csm2883684oag.34.2022.06.17.12.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:07:37 -0700 (PDT)
Message-ID: <d2648cdd-1814-688f-2285-d61ca65cac64@gmail.com>
Date: Fri, 17 Jun 2022 14:04:39 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 01/15] netconfig: Fix address format validation
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 6/15/22 19:02, Andrew Zaborowski wrote:
> Drop the wrong negation in the error check.  Check that there are no extra
> characters after prefix length suffix.  Reset errno 0 before the strtoul
> call, as recommended by the manpage.
> ---
>   src/netconfig.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Regards,
-Denis

