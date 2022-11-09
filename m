Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB6194
	for <iwd@lists.linux.dev>; Wed,  9 Nov 2022 20:32:57 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id t62so20054330oib.12
        for <iwd@lists.linux.dev>; Wed, 09 Nov 2022 12:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVvG+HeY1RH4/i4l2TE459Nuy5tSD+qemiunE8SrQyg=;
        b=Q7cu9Py+qVUcq0QKBfwlw6QV4kzc3xaMagd/rmvLIHd/4X7xmg+nNFOFRz5JVQJifu
         LnkyIUoj8xm1QnMxI0jmKy6SLhvT0VFwyNUKSZuKw6hdQLMZG8V7rf8vj0pqfQjQVL3N
         5AKAUtKref9vLdtmBErayz6KJ9zdIw6ckZ9+M46fwlVExNkZvQB+5BPetDUU3XfA6OCG
         GHpSOYOhukxG1n8u7h8prNHb5wh+br8B22QvYr440epaeVJjInqd5EyVVcCcAx3tDIDH
         /RXmGqHqFNiM5GDauuuyjxA/vUHrG5uKPt3JRJi/ZOTjO0zVUxRlaxE836r5phD3iWPT
         8k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVvG+HeY1RH4/i4l2TE459Nuy5tSD+qemiunE8SrQyg=;
        b=1523cNKZH7FEPUTXE5zvFCnmHvI56RS/kqyV+usYxWFQI+FuqBvfalIe7PkxBLu69J
         V05VS9wYiwlEMS7UqvFk5R+Zys6mH8gQYgAmR7IOfZKZ4BfgJkeA5MPWgJIdnwmsYOAy
         aYUdaVRPkUx7OJWtSOgkSkwzwGhWZ+5Rf3e1fMm386C4N23SwyZNjyGD1zyzaUlYFMBU
         23Yde/jVwEmwco0oVQ9o2CAsuRSPZUnVF3Z23lOF2WOwBvsBQUuavB//EI+4HiiiMHPm
         X0RRTz/7mw95a+XS2qzH7n4O0a7ezFF7HJpvimU/BO07pdHUNUZrER2WUszzNICobsNi
         Ru8Q==
X-Gm-Message-State: ACrzQf0ZoqkdOSqcbWb+c3Ow9z9vaF4nGPXsxXjrsj8MGVhXGJH47nCp
	bQA7v1NPgVfKZ6a2mLnRSlI=
X-Google-Smtp-Source: AMsMyM6kiRKVrG1jD26OKYuHWAXEONCJgWH5U3gkIMq2hO2XswT554K7skntHcEmGAAmmogK+8vo/g==
X-Received: by 2002:a05:6808:1823:b0:359:bf5e:7649 with SMTP id bh35-20020a056808182300b00359bf5e7649mr38076446oib.54.1668025976400;
        Wed, 09 Nov 2022 12:32:56 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m7-20020a056870058700b0013d6d924995sm6606777oap.19.2022.11.09.12.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 12:32:55 -0800 (PST)
Message-ID: <7098a2cb-3e6b-c6c2-07a1-4491aac16fe7@gmail.com>
Date: Wed, 9 Nov 2022 14:32:54 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] storage: Add TLS session cache file read/write utils
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20221109170438.535300-1-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221109170438.535300-1-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 11/9/22 11:04, Andrew Zaborowski wrote:
> Add storage_tls_session_cache_{load,sync} similar to
> storage_known_frequencies_{load,sync}.
> ---
>   src/storage.c | 35 +++++++++++++++++++++++++++++++++++
>   src/storage.h |  3 +++
>   2 files changed, 38 insertions(+)
> 

Applied, thanks.

Regards,
-Denis

