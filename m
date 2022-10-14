Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729942F21
	for <iwd@lists.linux.dev>; Fri, 14 Oct 2022 14:49:59 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id j188so5265296oih.4
        for <iwd@lists.linux.dev>; Fri, 14 Oct 2022 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYvQqbsuIz03LBireaXwtxoDwVDqefYBjq3YCgq7sX0=;
        b=KhrJoed15gPoU2QfZ1phtT1nsOBEI1cDHQgcKfyKfZuSJdUbiqKzA6foDSIWEwqtTO
         sP9pbZdao9PmfjA1nNB7w0QVF9abtRS8l3woghSO8oSa609sz4uI1e6BnVXcLbrDuMxd
         xbJn5+8TLG5hdfB75DK+SwxGN/cb01vvInUE0pkQyUC620li/4MH3YUIPhwE2g0JLdOm
         ZM6eP74pgvHxBlhMaQl6qh//2TI3BWzOz4NQ3NmRAKRmQCEozka+Z2Lu5Bzc3p+J7Wiz
         g26fVbrc3phDNLjcybSjyY9bjvQjE012yCNFQPRE4ZdqE57lzOKYolKDCKsoXMClv6jB
         Yo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYvQqbsuIz03LBireaXwtxoDwVDqefYBjq3YCgq7sX0=;
        b=B6pZkdt8THhj3woM3Y59Sm0BAP+7JyuYAR8PzivYLB/py5S+NNJ22OAico2BWdzt7n
         GmX6gHnUTleike0nWBcU4zhHGjBT7GvkZTn04yGUoTwNj3YRMkvMXTe7wNDpcENgvTWM
         o4zqRR6DK5sAlnxEGrk/wvtZGemuZklU0YWgr/cTBab4ee6PZBciD82mW4LSm8oApkej
         MXq/3LI8eI9p8TulnjYxl4han4TZFc86rj7D2axkY55fz86GSF4/WvXgOrdhMufZo1cE
         6fG1Umlpx+mp09EzPA+RDwbjxF1b7qIaX6fFgg6QAVUOUYYnj+GnIPzQz+lztQEdbH+G
         bpRw==
X-Gm-Message-State: ACrzQf2FCJKq+ZeKc6mCaat7K11+vwaw+TOlTJO4ZXSE2yJN7UIeODD5
	YlCwa2Q5tJDGbbjKBrp8LKI=
X-Google-Smtp-Source: AMsMyM4wSFYxS9o9vUr5hDbIIwt/Kpnov+kQfRTzlpFdzR82x94u+k8/hXOypRxGUY8QbnQqxaU9jA==
X-Received: by 2002:a05:6808:1142:b0:350:cbdd:c9d4 with SMTP id u2-20020a056808114200b00350cbddc9d4mr2525574oiu.124.1665758998504;
        Fri, 14 Oct 2022 07:49:58 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r8-20020a056871088800b0010e73e252b8sm1401031oaq.6.2022.10.14.07.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 07:49:57 -0700 (PDT)
Message-ID: <00068fa5-b183-f702-ea11-50c2848c8d99@gmail.com>
Date: Fri, 14 Oct 2022 09:49:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] monitor: use int64_t type for NLMSG_NEXT length
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221013200240.545800-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221013200240.545800-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 10/13/22 15:02, James Prestwood wrote:
> Commit c7640f8346 was meant to fix a sign compare warning
> in clang because NLMSG_NEXT internally compares the length
> with nlmsghdr->nlmsg_len which is a u32. The problem is the
> NLMSG_NEXT can underflow an unsigned value, hence why it
> expects an int type to be passed in.
> 
> To work around this we can instead pass a larger sized
> int64_t which the compiler allows since it can upgrade the
> unsigned nlmsghdr->nlmsg_len. There is no underflow risk
> with an int64_t either because the buffer used is much
> smaller than what can fit in an int64_t.
> 
> Fixes: c7640f8346 ("monitor: fix integer comparison error (clang)")
> ---
>   monitor/main.c  | 2 +-
>   monitor/nlmon.c | 6 +++---
>   monitor/nlmon.h | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> v2:
>   * Use int64 instead of int
> 

Applied, thanks.

Regards,
-Denis

