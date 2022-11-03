Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089D63C7
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 19:28:03 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id v81so3062783oie.5
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrfxZdWNvWPxrJyaYbc72zSjPVjiW8KTXxNCF64oJYM=;
        b=irepDDF8ZZmNvcT8ErfeAkq57QtAbPJp0JYnhhQBr3RJkjZjfGw3I2ZMPlf0tk0u78
         mQvbQlM0wmIvCi5TLVThuFw8Ky0HkXj34uNahruzbxgvdX2CwWE3IhHWFR4qpPi3zhTO
         d1iuxYDc7mse3qzmEfNo6JfGK06rcCtI0Nkdp2u5B54QczD8pw0h5rLj5Q4y2cdXIXQO
         H4tMBLTzK+gboNvMN1/w+CHBHiwnZrBkCA6L/5aawl8CSBY1TTOopHJJY+D1HN8TAogH
         F01RklWzAY1jJFDDV+1Cww/NBtfyVxcXw7DPpE7KO0Q+1dVNkZUYcRczAC78Y5t0yjUX
         ymFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NrfxZdWNvWPxrJyaYbc72zSjPVjiW8KTXxNCF64oJYM=;
        b=qUgpr3ls2uwVsVmuybKuVslyX45g71TfjFZsRHOji+uhgzkJjeWKZH64yxCPlTptfL
         57A68JaIpgy76WdnlHKiOeZbByJ8o3tp70FcnSWFnSVUWABYWUKvx/0f5DDXNet2MEyC
         f0PqLdmR3ziJkW9uyWbW+zGbF+8bJiwofWyk1MsP+oH4hpI3RKGy7sHkEYsBJ1vfkH8W
         S87XNgNp2ZXlQRyxbu3MQlwYgxWWWHTZR5TjGx9C03+G29rEgGlre+tBPXjVSQdGtgFR
         LWOEz5WLi+AzfKH/KReRQRb6lplSSpc3kAVdECKbOg/mfu9JTI5sHg3CrrFMP7BuQOr6
         iSXQ==
X-Gm-Message-State: ACrzQf1fw+7TD+RWm3ez1A2iAlz9+z8Zhb8Pe4YtRxj3Bu/J6b6cEPPz
	K1nzXuDaya8soLWtLoZ2DSzpH+BTrCs=
X-Google-Smtp-Source: AMsMyM6h9T7y/zPl41Tf708YPDUUCn3VUd4dxTHQjmHBMaqdZE8/uBEDlEzpAp34FYsVyZ0s+Y3RuQ==
X-Received: by 2002:a05:6808:3dc:b0:35a:c37:3309 with SMTP id o28-20020a05680803dc00b0035a0c373309mr12480553oie.199.1667503682595;
        Thu, 03 Nov 2022 12:28:02 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a44-20020a056870d62c00b00130e66a7644sm808619oaq.25.2022.11.03.12.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 12:28:01 -0700 (PDT)
Message-ID: <d971ba86-ae2c-ffb2-e97b-fde3f9030c53@gmail.com>
Date: Thu, 3 Nov 2022 14:28:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] doc: document AP properties
 PairwiseCiphers/GroupCipher
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
References: <20221103173057.381232-1-prestwoj@gmail.com>
 <C39B9D23-000E-44A9-AFFC-3805CECAE5C9@holtmann.org>
 <239fb4e91036371a8e1f9dfb93556cc3d97c902c.camel@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <239fb4e91036371a8e1f9dfb93556cc3d97c902c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

>> why not array{string} since that makes it a cleaner from an API point
>> of view.

Yeah, I concur this would be better.

> 
> We could do this yes. The implemenation has already been merged but we
> could change this to an array easy enough.
> 

Yep, lets do that.

Regards,
-Denis
