Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE927719
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 21:41:18 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id p127so105882oih.9
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9G335LjkJKa6NZtc0YS8OPy8FBT5I7z6gA1mRsCcIDU=;
        b=DM8g/1vjIUK+KzbyzymjLESDpl5kJKgW5c8t+ypELL3HiwVq73N5h6AC9Wc331vIMq
         r2tSjeBuWwN6SaYvSBGG5ZsCLE4e5+mP00X0AphS5QocZMKlr8vj7LrodvfLqcrUTyVM
         BWf+5XWjwhw+eR0R5DutHeQpRyjc5EC0V9tZxWJNPSpMDwX3VmS4BAQVVptYWTBVAjvr
         PIneAVh+NQXx49p8QFX4Bc6vj3Kj8b4TGxWhgWoPWBLnHP9vxEpLKTZYNAbpenx6OcSk
         h4Qdflz7HWiCcaI6CH2KB/HKDZhhlpKsHnweJv+IB52Ut7Ftf71Gv9Q/5Ox1lSfPFWu7
         4Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9G335LjkJKa6NZtc0YS8OPy8FBT5I7z6gA1mRsCcIDU=;
        b=uX5xULJJNbVeq/51dPG6M3xC7zbAUfbsmx3FwxXZPnL3JRg/80vPIR1G+2SBMp973b
         qISQfFvRDki/zo+Q3oqabjpbjGBIFX6O16WVWfylNeNOgIcKSpzjBN0l+BnOjSzw9a4a
         mUHMDn9CRw0YalLJG01lciW+9n3xFAJQxKZYwNQSvfLclS4JbJ8iqKwaUuI1VRkhktzv
         XGnkcf+ZJ5NZkBUJsHp26lbRt7q/GxA7vabr+f6u5cxY41xB/DBXCODepJDYYiPsLKzh
         y7sY6hDBeKh/iTPJnzxFSPtqrhcNMNrt+SUTCDjCGi+ccIvXVbO80qcalrrF3MUlhOah
         rZNg==
X-Gm-Message-State: ACrzQf1/3JMGk7Uczxi6hL4jycGR3klptWnspbsHm99QJlOOdEkBkoKZ
	stMi/9/A5RR5U8YB+lH134g=
X-Google-Smtp-Source: AMsMyM58ykWtae8hoGlh623wnha+7NP/fj8XIUH8Vl5RMuxoAYK4HRtWDzXuw/wFXHaCUfL0Pw3YTQ==
X-Received: by 2002:a05:6808:2118:b0:359:c612:b2d6 with SMTP id r24-20020a056808211800b00359c612b2d6mr19441441oiw.198.1667425277007;
        Wed, 02 Nov 2022 14:41:17 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y7-20020a056808130700b00359ba124b07sm3531592oiv.36.2022.11.02.14.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 14:41:16 -0700 (PDT)
Message-ID: <de088f25-e4b2-4b40-c5c0-213e5baec91f@gmail.com>
Date: Wed, 2 Nov 2022 16:41:14 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] client: fix extra newlines in station show
Content-Language: en-US
To: Neehar Vijay <env252525@gmail.com>, iwd@lists.linux.dev
References: <20221102202258.289396-1-env252525@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221102202258.289396-1-env252525@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Neehar,

On 11/2/22 15:22, Neehar Vijay wrote:
> This change removes duplicate calls to display_table_footer(), in
> station show.
> 
> Before this change, the bug caused an extra newline to be output every
> time the table updated. This only occurred when the network was
> disconnected.
> 
>      $ iwctl
>      [iwd]# station wlan0 show
> ---
>   client/station.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 

Both applied, thanks.

Regards,
-Denis

