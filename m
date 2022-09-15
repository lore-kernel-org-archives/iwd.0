Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095024C91
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 21:20:17 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-127f5411b9cso49362587fac.4
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=qyuq0nXeQ639C19Jv14c+Y9yqUlHRKGNNtIWZAZ1LRE=;
        b=GauTxiE04GvEkPp7dfX9xFwgLyC7Y8fCrkF+dOWv9O++f3nJskbjdE4mOcKc5OrWH7
         hzmWnbrzCfxMRwWRfmuy/q7L684XUnuFvicDa8yXDOrx76cv2SQ0hh+x43F+fDAim7/J
         Lrbhxf41iKxB1E2l4Xi+g5dEJhOa0PjIymVgZCEBDHM8RTMHCmYxojTHU4usIrXfFmiV
         aUsa5ytSr/pmgRI5omVlJEeX+qROZtQhRrjrpYCEp/0TNVlw29p/iRMYCyzZJ0n7NqBg
         ItFPfztxLdChD8TL0spsP/PdNddUZFAiROJZXGMbsVr1z5AAfKgeHVAT6igUgbukp8hv
         hrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qyuq0nXeQ639C19Jv14c+Y9yqUlHRKGNNtIWZAZ1LRE=;
        b=NY1Uq0spZxkKLfmi5+hRsiMnCk0wHppeiArdbiavXw5kmPfbDG3KQWb3pEAsrXuDjB
         a4a3Zkf9FYu3vT7ZYdOGtC+AjPDpc7Bn3fciEkZ9IdrVFxm6FhYTi+96mgiWVw9fIxdU
         MQWnbrlmVj+3zYyplFBbh/PlOa5PHovxwcAs6goZpAanyvqlf7ra0MjAu8FJTOAEYsvw
         MiTc79XKN03OA6a9dhyL27xaOqgiHcb4eVcs1t7tt1TZhwCqtevEx47dhxxm+rMVjmVf
         +2co/vC6P4KeZZw+leYsZVq40q3OhFPw4lUqaKUAPf7Tpaozzjff0I5zXQNoqldBTP2w
         EA4g==
X-Gm-Message-State: ACrzQf3jlBOZydZ5T4VJrzckt7kevfCKFxheIDKpwc2YGi8SIgt1Krdf
	Ug+Sjf73wnzNMVDVoO1Uh2UbCxkdquM=
X-Google-Smtp-Source: AMsMyM4vBvpjY6PJm5zf8FrQMoEMb05wBoLzqmjysIfGnUL7jAgEStAKnUZHDQLcLarXo1mO0yShnA==
X-Received: by 2002:a05:6870:a78f:b0:127:ef52:2c7f with SMTP id x15-20020a056870a78f00b00127ef522c7fmr924209oao.237.1663276817088;
        Thu, 15 Sep 2022 14:20:17 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cg18-20020a056830631200b0065818e6fbdasm2194626otb.24.2022.09.15.14.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 14:20:16 -0700 (PDT)
Message-ID: <ef1d0f7e-10c6-d2d1-4a86-c09571c68372@gmail.com>
Date: Thu, 15 Sep 2022 16:16:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] mpdu: fix timestamp size in mpdu frames
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220915211853.1093078-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220915211853.1093078-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/15/22 16:18, James Prestwood wrote:
> Beacons, probe responses and timing advertisements were only using
> 1 byte for the timestamps which should be 8 bytes.
> ---
>   src/mpdu.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> v2:
>   * Use __le64 rather than uint64_t
> 

Both applied, thanks.

Regards,
-Denis

