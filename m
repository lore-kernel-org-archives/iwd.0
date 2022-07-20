Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916C7748C
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 22:52:08 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id x185so12756733oig.1
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 15:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=zzqxef0fJazWhgFydBqLOwkaeS200vqU/2Fmp1y1v8o=;
        b=nR/SKVaPyfLOHoTPDXmaHViEpn5BeqFeTxlRX6iBJoyVJ2s8Pep7TXRI/cOJyIaQgO
         IbHRWFIAUGYoqJ0keZ6oslpzUXtIIp3nIMwFYh1BsR/Z/rgFOGnvTf8SlSmZjZIxx6gz
         UzETyR3nu+kWKs+BiepXQYyxoSn02uuHJu0DPVI9NtbPH3iEvbMLegKYnaSLt75mujTz
         sHd3BTdfFFEriZg5TUUMtj8uRda0VWw4nF3MiCzALuTAV5qaz22ftN8EyoXqrLVlqrwN
         VBuXx6bZwvpUC5bTSautFcq/3D1c0hmdzdWSC1GTuuDazuntau84wv8N3g5Ul4dVk9Az
         1scQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zzqxef0fJazWhgFydBqLOwkaeS200vqU/2Fmp1y1v8o=;
        b=wiU5uFKBdKFeOEn1TM7+uSrivlcpnk2xkR/oL6dc8yD7I8K3fPHUTl17lVxp4+u53S
         +YagIvesMrcMs/3miEZ9jJh5ci6zy0grJFijbHLnAf+YAS3bupsWdxPBLb0ZEgrwm0iK
         iGQ5NHNhwWKBmkCiAgqWeTwxTOM6VVNAsLcN1FbKBwqc0Y+8Xq5cj6h+AY2EgMo4XLwe
         mlONj1sTru7aBk92xYZp5bHVShb0W+f+YeMmEXKbWWxmfx0FjzB7Pl+/s8SEXH+fmWfr
         X9L19CBB6oToYkRP7vwQNFARG4k9E3UF17Reql13+n6ITdLFse3wYS/1ooOqPHg+LXb3
         OATg==
X-Gm-Message-State: AJIora++rKEkH0ZQJ97PSrYsBL76/r7DAa835zLlmEivEcQXANWjq4d8
	J7wCnBtm9xG/qGBqCKCO+Vc=
X-Google-Smtp-Source: AGRyM1t9VkjB9/ADvAgNgS86cP7AeQqU/iIFrE1ZDHIYrtVILN4hcGCQ0OBQZnYUyn7Z4VTUYPToLw==
X-Received: by 2002:aca:5944:0:b0:33a:a1dd:def2 with SMTP id n65-20020aca5944000000b0033aa1dddef2mr2266728oib.13.1658357527673;
        Wed, 20 Jul 2022 15:52:07 -0700 (PDT)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id k6-20020a4aa5c6000000b004279be23ed4sm109554oom.41.2022.07.20.15.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 15:52:07 -0700 (PDT)
Message-ID: <80fdea9d-3d7b-3332-eba2-f88087232e25@gmail.com>
Date: Wed, 20 Jul 2022 17:50:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 1/5] ie: add validation for HE Capabilities element
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20220720221507.886811-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220720221507.886811-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/20/22 17:15, James Prestwood wrote:
> This makes sure the width set bits are sane, and validates the length
> depending on which MCS sets are enabled.
> ---
>   src/ie.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>   src/ie.h |  2 ++
>   2 files changed, 50 insertions(+)
> 

All applied, thanks.

Regards,
-Denis

