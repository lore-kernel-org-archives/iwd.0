Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011844A02
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 18:05:14 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so13810870fac.12
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 11:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=jP+2iPPkla9M2GXbToEIsPUgMAl1tbvhViUyZPAP2Dg=;
        b=CNeKvykflcWwGuCiXXrNhb2cLDeQ5IEzrC/ysjxZiqM2uV2uktAO0mjlT0l45EBER/
         zAaj7Dc2dloPiRuuYnhdcw2jmIEaSu49mZLXxpxh4Ifw3RrRbernN90j3mseM6joZjlK
         tQbj51ewdzNlkvWwfkkWQx/74k+jFSs63BocDStuBxxoL8xMVTFcKydfOLBXguB27wmO
         ZF9VwrVcCVvyO/xo7li1exMhx4mftdZqviK9kU4mjmedpiJPGgWgd7NNrEJDzG0XSIuO
         sWE+IiHd2VOK1XbI6jHmk0Vy6ew+In8+Gi3RTRgjl0EiVBz668lFO+9hIQJkXZ5335Bh
         w9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jP+2iPPkla9M2GXbToEIsPUgMAl1tbvhViUyZPAP2Dg=;
        b=8J+HHeNri+FZiFaIpo0JuU8rJq3UbMzuTWJhcE1E1Ju9TK9oiDASJLG8/l3QaDOZHX
         M0CmuCyueAIxcZtlb6cXqxZqfEA2fXJPcTcEdnef1RF/eodyGEc0d/jT2RasMi/i685S
         WY6oE0jV5ouSf6d0ic++Vu2xe5b7c3CPSKO+QmTrHKcyOLpsnEp7SOrzWwp0dNf0gjKz
         9oR3/4AIaBfD4MQwELf9yZisxt0J4Xo1X6aqYplB5F0f6YXvA7E21F4VR/x0hfp2Y9rD
         1zycN+9uSrZrzuxGfuHBy7jhv82KK9tVBmBzXF0B6Z01w3e+q0mkhIXZ/Ehn8Pzwg57C
         luMw==
X-Gm-Message-State: ACgBeo2zGGXHNaOQ3CVzkrWjPaSFfISBGr+lv0Gfhg8cIGpAtLjY+gCR
	cPidOQt0NuX8k1XBX0rIUx75LurHi9o=
X-Google-Smtp-Source: AA6agR74d8ocZ1JfwAfo1bRF9jgUUO1hS6quE7jyv+WyrszOBCgxakKLI9ew/+0SbXGQeZ3eGyZiow==
X-Received: by 2002:a05:6870:231b:b0:116:7e15:1593 with SMTP id w27-20020a056870231b00b001167e151593mr12267785oao.268.1661191514086;
        Mon, 22 Aug 2022 11:05:14 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id q5-20020a4a4b05000000b0044b0465bd07sm2071250ooa.20.2022.08.22.11.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 11:05:13 -0700 (PDT)
Message-ID: <7e2927c2-089c-71e0-951c-ae7c5092ad47@gmail.com>
Date: Mon, 22 Aug 2022 12:54:14 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/6] auto-t: fix unreliable behavior in testPSK-roam
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220822170150.2049490-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220822170150.2049490-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/22/22 12:01, James Prestwood wrote:
> The packet loss test had a few problems. First being that the RSSI for
> the original BSS was not low enough to change the rank. This meant any
> roam was just lucky that the intended BSS was first in the results.
> 
> The second problem is timing related, and only happens on UML. Disabling
> the rules after the roaming condition sometimes allows IWD to fully
> roam and connect before the next state change checks.
> ---
>   autotests/testPSK-roam/connection_test.py | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

I went ahead and applied patches 1-5 in this series.  Andrew still has some 
comments pending on patch 6.

Regards,
-Denis

