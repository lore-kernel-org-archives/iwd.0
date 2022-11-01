Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79917B
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:56:57 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so9204920otu.1
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46+CVzqAxwc6+MyHFqWNO8UWhImnml0SLg4KS1MJTlk=;
        b=Xcok+TERYKzzN8z1LtCqx/9fycsEh/WbeYlDekk3WmDGBN+vrH3BhlXN0s09yDrEjo
         1eChCeBmx17rwsxcSR3yp8dvY4UNVfUAyPeHqhEfP7vRw+dOuSyPc1AlSejrZTOyJnXx
         c938XvVFvrFlodmwEeFIpBp60z6vtnhppYRDccf8Tih+Ic+DnpO7J/kgSRrBClOg1QGH
         WiGvT66wwH4PFCUMAZVzYgAepdO+JXI0ucuW4vSNGsJugrJ8J/MzKj851nb1i3Drg981
         0PthIpyUP6JemWaWbRqehflPdiqyoG1XmE/iDmECnC5JFNqRo0YRu1BGRP1L6y67BQHg
         GZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46+CVzqAxwc6+MyHFqWNO8UWhImnml0SLg4KS1MJTlk=;
        b=aCIpKXRgjOXXmWHFcF3p52WNg8y4D4Ge6S/zlWGRuBeySkguCQeQVWeKPT7AP1XWq1
         eRUkJoj7Lx/tr0MfPnQCeCRO+KkotSdhb7oqE63Vh/ciNOLlZARmYSfYUAIoHH6sl5xX
         vgKMavk98Kb0IoODZKgSo6FF5n4bifUz9UqVXe0ob0MLyD4tLA3OIFavjT9IgiA8Hb1s
         X3v0F6OKUUK4uFn14g3SilPPjCpqUz783t/yh9mJ0n3qy7e3BqmZl2WTmMacakgFEYFC
         kOzlvrZvyDvOrqpAzgPBxayxfhiDe8krTBtnCtzNCkTSIY9EK4B815L5jOSD4hxIftVs
         jgMw==
X-Gm-Message-State: ACrzQf3O5iJAeJ++CXOSRQjhXX6qw4asixwC4NOiZOGv/rKJpM5HD/Gz
	h82WblOViThnJFqfCbsG4bRe6HJamZk=
X-Google-Smtp-Source: AMsMyM7Nrbz50azO33EpwgsbKRbvUE9fdjX3guSmp/oyEO6MrB3d/7iuUoe5t4tVcSHNEIhtnUwE+A==
X-Received: by 2002:a9d:2625:0:b0:66c:5694:f4ce with SMTP id a34-20020a9d2625000000b0066c5694f4cemr5527623otb.145.1667336216976;
        Tue, 01 Nov 2022 13:56:56 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o195-20020a4a2ccc000000b00480816a5b8csm3815453ooo.18.2022.11.01.13.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 13:56:56 -0700 (PDT)
Message-ID: <bcb32526-f30c-b14a-d0fc-50b7ea054a18@gmail.com>
Date: Tue, 1 Nov 2022 15:56:54 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 15/17] nl80211util: add key type/idx to
 nl80211_parse_attrs
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221101201747.143379-1-prestwoj@gmail.com>
 <20221101201747.143379-15-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221101201747.143379-15-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 11/1/22 15:17, James Prestwood wrote:
> ---
>   src/nl80211util.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 

Patch 15 & 16 applied, thanks.

Regards,
-Denis

