Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4970AD54
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 21:49:31 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id g10-20020a4ab4ca000000b00481082808cbso2348187ooo.10
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSsuucDli0RQ1VHDjK6hmxVdFJ8EnYv/5B9b4wvkYQg=;
        b=DYMQnkGKSq5KD2o2nAo6h6S9cplfe6v8QO8RlxdfUFTBy1wP1rf7qEweVzPEATd0CO
         ssbN2v7wo25XnTd9NhTqfrJmd5kxlh7XPqetlxefe1Lh7mCkMYdYqpBQFSYX7hOaACiZ
         sMjr1+lyQAuIdZ8SNtHHfI33IGkOm3X5Q/rvgARvuLqMafvv9z8VmBvIaCnZXae9FiM2
         7QWvsGnVxhZ3U7DjnKjUSTG1qPBaBOxAmrdcuBoHVbbul+2wT8Yb0XP+ofqocukbgSK5
         7QroqX8pmGbSGliC38YOQ6Mn8M8IkZtOp87m+53LMohUBoAP5QrTdhWXBr6hcCVismT0
         tBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSsuucDli0RQ1VHDjK6hmxVdFJ8EnYv/5B9b4wvkYQg=;
        b=iQAfnkXcK6SGwVH92Hz3Qq3hStFBfJZCU5e6jKXa6GlU7QeoEyhmQskE/dVZAx86Vc
         bnew1Vob4RzeKl555IaZVxjCwA6rMsvoNHRHXlsdE3Lb8OmueQKXtpNaHrGu25ZUnbti
         GoSfOkxpJWKQde/RCoSffnBUyUOlHY8OPgYOc02boHtKQJkkMvAtQjcnk/1rn0FlFx0Z
         A7ixZQOEq/aPXWqi++QKhOn/DdyBiTLawMsfMdrtukgNSpF4Pv7pZR6jaxW2VYkyj1y9
         2ezezzXtmVYbjI8MxjfiY3b4vV1vqJ5ELVbCE4Fi6vpxnursWC9EFxa6oKyOPVcj2MMy
         /8qg==
X-Gm-Message-State: ACrzQf35dXf25sR9VMPKgHRtkgLeHsqO0q0b3qaQZk+lebzF3Z5T9jTZ
	EbBm6aJLo94UAAET2R8RZ2c=
X-Google-Smtp-Source: AMsMyM4UPMGH2bdhnCD/PCCIosmOnDluPVU2M4Cs/sQ+Gw0NjuP4/4BfsyM8YSMlB5hQPxoVhzET+A==
X-Received: by 2002:a4a:9cd7:0:b0:476:aa74:9f61 with SMTP id d23-20020a4a9cd7000000b00476aa749f61mr19856098ook.37.1666820970848;
        Wed, 26 Oct 2022 14:49:30 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s22-20020a4ae496000000b0048fb9b6dd70sm1811737oov.0.2022.10.26.14.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 14:49:30 -0700 (PDT)
Message-ID: <554e50aa-2fb2-b463-8a30-708f0e8a3f86@gmail.com>
Date: Wed, 26 Oct 2022 16:49:23 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] monitor: pass config to nlmon_create
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221026204559.502432-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221026204559.502432-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/26/22 15:45, James Prestwood wrote:
> Expand nlmon_create to be useful for both pcaps and monitoring. Doing
> this also lets iwmon filter pcaps based on --no-ies,rtnl,scan etc
> flags since they are part of the config.
> ---
>   monitor/main.c  |  8 +++++---
>   monitor/nlmon.c | 15 +++++++--------
>   monitor/nlmon.h |  2 +-
>   3 files changed, 13 insertions(+), 12 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

