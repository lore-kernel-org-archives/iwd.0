Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157218631
	for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 15:27:55 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6c61a81f4f7so2999777a34.0
        for <iwd@lists.linux.dev>; Fri, 29 Sep 2023 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696001274; x=1696606074; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIoKSZsAYpbL2x1X7EfY2veBZkQNRIbhHNFme86tyV4=;
        b=O1V74j/USCNtBNb/fOMwTGLPLje7+ES76WOCxff8NGE6uZeyxKIZ8xyUE+crBVc+zS
         Mdxd1nDzsLo1oKJlOq5ib2epiBJOxK9oAEF+dsB1Rn0S2DYuBNKcy3yBuaoEQzcOALwv
         RKk1gofpeRCOqZ2JQaegD/sJtjjXwjOh6rpnAlZ01tlTkOte0oWbLQgFKMW4kf49Bvno
         uFuU88k9qfG/WU++WUSK1lyI5vpIWyzzwnB+eVjTc9UTkC3y0mokb8fQ+DurCxYU6kOi
         /yv8k3MY2E/8mBxW8+rQUwGi6qjTJWEY4SYRbNQo5cEFan624dov62AwzmpTXfObgpMb
         YJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696001274; x=1696606074;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIoKSZsAYpbL2x1X7EfY2veBZkQNRIbhHNFme86tyV4=;
        b=vjpdfpTKmV45aTxubkxop9BmTvqCczFlld8RJqJz2qqRtZhivRDf/2n7p8wySGbVQc
         WQN+04d582Qlk/9gem3NEhk/ANvLd9WEaKTVsg32Y0w1YT7lUWMiPGPiB2ufPuR/+H24
         XsgRfAu/sT3erXzvgwDrFYgf8yYbunB8VjsIECcfFi/6kYPfr8QwjulOTdt7S5PQ2Chr
         pn4XMebtchpFm2qNoFTj+8wRxdlwT1Uqum3ZQo39YE0Cp08e+v+n4+UpYmanRut4M1Wo
         zVrNP3D/l44qExJ6ywtwBXzAXJZFxdSf6viC/cOpxha+ki9lv9cgHJW+J+oE30xlGc3K
         FtCw==
X-Gm-Message-State: AOJu0YwxhN0kmL0VBWc2ozbsLpRRzMAVjtj4+n2b8bAhNixM2agSnWgR
	dKG3vWOpH7+GdqcpHTlqseErmXZWjLM=
X-Google-Smtp-Source: AGHT+IFl6X5uLWq0QI8if/rXs4vUsZZzcwAjltGC/tJFxkhtcGB1FzilR2Lwk80HkIjX0acozJSDqw==
X-Received: by 2002:a05:6870:b61c:b0:1dc:8136:e5f7 with SMTP id cm28-20020a056870b61c00b001dc8136e5f7mr5306835oab.48.1696001274542;
        Fri, 29 Sep 2023 08:27:54 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id v3-20020a056870e28300b001dcde628a6fsm2853306oad.42.2023.09.29.08.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 08:27:54 -0700 (PDT)
Message-ID: <4eeb4b3d-1081-eb08-008a-8fc19d525c62@gmail.com>
Date: Fri, 29 Sep 2023 10:27:53 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/4] scan: filter user-disabled bands for periodic
 scans.
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20230928124128.3793788-1-prestwoj@gmail.com>
 <20230928124128.3793788-2-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20230928124128.3793788-2-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/28/23 07:41, James Prestwood wrote:
> To support user-disabled bands periodic scans need to specify a
> frequency list filtered by any bands that are disabled. This was
> needed in scan.c since periodic scans don't provide a frequency
> list in the scan request.
> 
> If no bands are disabled the allowed freqs API should still
> result in the same scan behavior as if a frequency list is left
> out i.e. IWD just filters the frequencies as opposed to the kernel.
> ---
>   src/scan.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> v2:
>   * Simplified how the freq set is built. Instead just clone based off
>     supported and the band mask. This retains any currently disabled
>     6ghz frequencies without having to create a new set and merge
> 

Applied, thanks.

Regards,
-Denis
