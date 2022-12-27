Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D033D1
	for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 17:20:22 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-14fb7fdb977so9463878fac.12
        for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 09:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzTkf96QlSxb026f+RhjITdHY/ljvVhrqvMP2nq8XGA=;
        b=IaR3o8VC3riBa6K97GIDcEd9VXuCKmsIuMjZ6Pzq3apjwx1bNJj3giPZquLqwVPbQ7
         D9Dfd8DRtGVvKBKoV77GUBRZY3MU2zFHeTNKJXMi5oCKZJcD3oGzClVIjOvqx98vZuEb
         ugeXajCpgOJZkNTpD0iGwtLsv85WyLBvvKm8jZ1Yc1MJybQ7+W9uvgDsnSZNesuC1wcC
         N0JYD6b7h6XrUYrzO0kInTuZetOuvgExXJGYdPoGPoLEvpZ0bYz3rqyVOwxXwQvzC/pz
         Ws8L9aY7O0HwmVUfmkn/yBxySShC1KG6hWapzE0Twq4a762Sy9T/AB0Hpj7/U0BNEXi0
         v+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzTkf96QlSxb026f+RhjITdHY/ljvVhrqvMP2nq8XGA=;
        b=ClRPOSbRqp9K1svM/Z/wljSjk0eLWkwHLfWNPUWLDhgvhcggvK1p3Loj71cd2a9yFg
         S3Q0cFOjsC0rIXmxUSEqAdoO3QWrtjXq1sMgPS29ek+77DnlRulOK/TOXulUjIkZ9zov
         f9G3ES+fahlrQJo3p8LLe9qE1116F5i1+XbDu2ZEPKHQuZel3/7bEO7E7BM/cKHHWGhz
         CaeRD/syUh3P9LzL3WxSCOaNiHzgWkvYNtJ4RDAFMn6nfhmyfpm/aDHfeQKWAgiO7jwd
         Gcdn0T7heI7ZzCtHDiSTq71qAD5tqfSHasFMz8gT8oX4AbKbA2vmA3+VmLId6lSyK6qD
         IshA==
X-Gm-Message-State: AFqh2koKbQFa1yMpgi1CBWDHVGWWeExJ6LA3DpRlvkf0Vyj8J1bxkvcJ
	W3T92bf5VSGuzeDVf4mBf7w=
X-Google-Smtp-Source: AMrXdXtGPR7OKcY9MwOQsze03Fhscm61lUT8wE/9w4ma2JKhBsOk3RELaWC34UGQ8qfE/fBV9z9gwg==
X-Received: by 2002:a05:6870:438c:b0:144:a3cb:3fe7 with SMTP id r12-20020a056870438c00b00144a3cb3fe7mr14011828oah.40.1672161622073;
        Tue, 27 Dec 2022 09:20:22 -0800 (PST)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id k14-20020a05687015ce00b0014fd7e7c3fesm3261709oad.27.2022.12.27.09.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 09:20:21 -0800 (PST)
Message-ID: <816f6e6e-f523-7c3a-48d8-c3601fddf2ed@gmail.com>
Date: Tue, 27 Dec 2022 10:59:29 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/10] ap: make supported rates a common builder.
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221220214318.2041986-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221220214318.2041986-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/20/22 15:43, James Prestwood wrote:
> The supported rates IE was being built in two places. This makes that
> code common. Unfortunately it needs to support both an ie builder
> and using a pointer directly which is why it only builds the contents
> of the IE and the caller must set the type/length.
> ---
>   src/ap.c | 68 +++++++++++++++++++++++++-------------------------------
>   1 file changed, 30 insertions(+), 38 deletions(-)
> 

Patch 1-3 applied, thanks.

Regards,
-Denis

