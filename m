Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7EE63A5
	for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 18:13:32 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1442977d77dso16265517fac.6
        for <iwd@lists.linux.dev>; Tue, 27 Dec 2022 10:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohm2gHruDUbyYVjj2rYigQGKLP3iBaOqLpjYXyuJUEQ=;
        b=fkQgLWli0NeQc2UDrF+QDSnzh3oq/YKo6f5F6d1NVrgy/MG6p3qroqwRXZwNFS8t19
         baONiDyimWmz2OrTj9olewELo5k/MaoO8VnfhhYoEj4pgB/3gHetG+iSsFVK5EshuqTV
         t+7LbkXBIdePQCthyP7HSwLZUCq4Xu8RT6IK37TkvJI0vc04iOX4B5h/yMRzREj6oFqB
         ArVVUGSwlAtuw6yNqrEYqN34XbPg8obB1Kbf01EsnX7cVU3onpgPzWX36n4QRftC2ugo
         thP5Kk4N5RKwLVTrt2VNHcG9XylmR94p0M8cNz/BX8lThz/bh1xRVmtTvukNX6dJNsvf
         mykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohm2gHruDUbyYVjj2rYigQGKLP3iBaOqLpjYXyuJUEQ=;
        b=nMbOZuMvs2l1yLqkUmA64YrePTBerSfEkIoxo1iC5SIRWufsfvgNaC/EsjYugZsglA
         bjRWTA00f7Fb6i3+p4ZQ4Bz4nYr9sakM6sGcC7hvPu/yYNLj7IjHQF+ymXLxk8KApOGY
         fsuJzl1RsmLo6DU4IjHSJ8sVCjC8lG+asbfg0tJqthECTg2ve0YI1xZ977rbTSp4yWNx
         6UbQeOve2OYvoibuJ9duEOYkTmW3tzHgVRNwFQI0UVNvQgDAFRthYxamrQVIC6X8Rjla
         2+aXVtNZ39+ioqGuLbvrXFgB1zLtknKmvu/0IW0oFUvo91OW7G44gY6LacgMov4l4bLu
         B/qQ==
X-Gm-Message-State: AFqh2kq65m/MVuyNu1ISa0UzU8EgiiOqm+ruv/6LTpuI3to0o6DfVyR7
	BWEb04j/iv9mGZcaez1HaDA=
X-Google-Smtp-Source: AMrXdXvBcieAJScLiRJJJ3Qjw6rlxlwTS8fqHP51tfxYdpAPjhm3DVCyU53g4ogFh0eWIMLeQJkrBw==
X-Received: by 2002:a05:6870:44cb:b0:14f:afd4:9bfb with SMTP id t11-20020a05687044cb00b0014fafd49bfbmr7571687oai.48.1672164811534;
        Tue, 27 Dec 2022 10:13:31 -0800 (PST)
Received: from [10.0.2.15] (216.106.68.145.reverse.socket.net. [216.106.68.145])
        by smtp.googlemail.com with ESMTPSA id b16-20020a056870471000b0010c727a3c79sm6390426oaq.26.2022.12.27.10.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 10:13:31 -0800 (PST)
Message-ID: <7d03905f-66cd-a338-0280-b26f99733334@gmail.com>
Date: Tue, 27 Dec 2022 12:09:51 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 08/10] ap: include WMM parameter IE
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20221220214318.2041986-1-prestwoj@gmail.com>
 <20221220214318.2041986-8-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221220214318.2041986-8-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 12/20/22 15:43, James Prestwood wrote:
> The WMM parameter IE is expected by the linux kernel for any AP
> supporting HT/VHT etc. IWD won't actually use WMM and its not
> clear exactly why the kernel uses this restriction, but regardless
> it must be included to support HT.
> ---
>   src/ap.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 

<snip>

> @@ -842,6 +846,56 @@ static size_t ap_get_extra_ies_len(struct ap_state *ap,
>   	return len;
>   }
>   
> +/* WMM Specification 2.2.2 WMM Parameter Element */
> +struct ap_wmm_ac_record {
> +	uint8_t aifsn : 4;
> +	uint8_t acm : 1;
> +	uint8_t aci : 2;
> +	uint8_t reserved : 1;
> +	uint8_t ecw_min : 4;
> +	uint8_t ecw_max : 4;

Since this bitfield is multiple bytes, you have to be careful about endianness. 
  Compiler will store these bits differently depending on native endian order. 
See src/mpdu.h (mmpdu_field_capability definition) for an example of how we have 
solved this in the past.

> +	__le16 txop_limit;
> +} __attribute__((packed));
> +

Regards,
-Denis
