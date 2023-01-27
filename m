Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A133D5
	for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 18:22:04 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id g21-20020a9d6495000000b0068bb336141dso570814otl.11
        for <iwd@lists.linux.dev>; Fri, 27 Jan 2023 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKu/oQ9GANKePvYx2DWifXKT3/629XCd3U9EKdhaxI0=;
        b=FD1E7+VuP4VCz4WtnVXBmGk/QPqhLPvnasT4bYsE8l1gnl65gFvLRVzn9jDx1AmjhL
         zeOKUkyqLf4VpaJarhhB01jOzgwRHsAL4twhZ0v1YpUaB76czgHGGN/n3ROPFuh3h4o+
         8NUshTecrNyjnG+OrISf2T4M6GWFsf6NZCmKrGRAEQSiGLvvi+JcNQbqD0elgJjiBRdt
         QeJcpyKIyzTktJ+6Rz2DR1zY8CP8phI2GzX/naddcwlNDBpI6Y/IDIHfcPfkgR/w2D3Y
         62c2uIcBH0BRGp2OyLdWsKkcD/+NFc5cT8leIzQLuTCHOmehV41fAhCJ59Ad3Pu6+Tbe
         4eEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKu/oQ9GANKePvYx2DWifXKT3/629XCd3U9EKdhaxI0=;
        b=ouLWbczJzFK5z8oBrFaEm4SpLI3DYBekN4PcM48myNteW+e/lskam1ypE66cFd3ToA
         IkgBd92EFwUKfKfRBtZgNjqVRNVBTlIRHbioZcTkZ9YfakPTD74C1ljPYg2UqkJ9UNtB
         SXDS7k8pijbuZdyyt4KlsDiCKLqGj/HsKKenC53B8RxropNWZcksiOv9VoHuVt8FvB/n
         Kud1jxnkBImMmGu0d4K8OLzf2jkvgwVTzghjv7H1gplbAwe5t2zNHWeGx7mB+TprTRuM
         DZiVgvU1pr0d27iu5cfajPyzuHxvDF5UTEwICj5J2A6F6aGtiMDjl7zUexUeyCo9cNTF
         VeVg==
X-Gm-Message-State: AO0yUKUfk/L55NW2S3VkaFEIHCx/b/X0VfrkGprBBRKSHPyEXnUjfGrO
	q2xcxeOd2UJj7NjCXsODy5U=
X-Google-Smtp-Source: AK7set96MEsBfqG+mFgZck3YhKxF7wmp/ka85HR9XfnqFo4gsIPP9xh6Vge3yHHU28IxywainNVqgg==
X-Received: by 2002:a05:6830:6112:b0:68b:a678:6669 with SMTP id ca18-20020a056830611200b0068ba6786669mr1291924otb.37.1674843723859;
        Fri, 27 Jan 2023 10:22:03 -0800 (PST)
Received: from [192.168.1.29] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cc12-20020a05683061cc00b0068abc8e786fsm1770279otb.10.2023.01.27.10.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 10:22:02 -0800 (PST)
Message-ID: <377c04bf-1a7e-6aa7-041d-303fb39fcb1f@gmail.com>
Date: Fri, 27 Jan 2023 12:22:01 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ap: correct extra IEs length calculation for WMM IE
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230127172930.2686333-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230127172930.2686333-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/27/23 11:29, James Prestwood wrote:
> The extra IE length for the WMM IE was being set to 26 which is
> the HT IE length, not WMM. Fix this and use the proper size for
> the WMM IE of 50 bytes.
> 
> This shouldn't have caused any problems prior as the tail length
> is always allocated with 256 or 512 extra bytes of headroom.
> ---
>   src/ap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Regards,
-Denis

