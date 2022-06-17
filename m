Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2E20E1
	for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 19:18:51 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id u9so6445356oiv.12
        for <iwd@lists.linux.dev>; Fri, 17 Jun 2022 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=VU954bJrgE2hJXH0XbdsvDHJJZJ4P3hHAyq9BKrzAGU=;
        b=TFOwYiimkjQt79E4zC0vzHcgL5iKCHk611oJ6ef0Emr6NX/oAPG46kk7gq2HGKKIom
         yphhvf6U5LtmDorZeaLvfvX+rUyCr/1aaPKdD6kX16rk1LIdDUpmQ49YdLQ4HPkjM0tY
         y+2sLGSfe9ZBrtFu1en8T7qlEs4bplg8up+4eYQtTGULEoPzwrOzIvfZ+pK5VbfBLQS9
         kwTHKrUnIJ4JqPgROnkzXxKMhU9DK+fSSXu7fgHp7R0HVrrmribzekp7aTPwXfdaIIyW
         8b3zIas7uLSASOS9Buz7MqVdn3MYMAMQHmfDnyE33yBnIP+pu6T6NovMieU6LjmDBIqp
         YKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VU954bJrgE2hJXH0XbdsvDHJJZJ4P3hHAyq9BKrzAGU=;
        b=WeJJKXGI92iRfxg7i+vIrCnVOshMRdK7WktAoRutHKHelX4qEzT6u6j5dbAiZYIdqC
         49W2gnDCTnUBapbMfL1uEWuENpwAVpVhHMa6bbGIG5qlETnhvrQGI/PcMHj5yWIKC3sO
         KJMzBV0NP1QoBAA6RXvwyJeGO90JQPStSTc/Zt6c3HeX1bhVN99jjNnT8yqZxrLPqPb3
         YsHQXCO6v77UCtEZI+Ole6KkuJjHD78+7RDc4H/AnDae3/0Hecko24TbBaCnBcdEaCvs
         fb4hb/hSG5MjW39DCdljdWgjNY3DA/ni7Mfx3rqTGnK5PRomd7DFTkxT00MhfZhr3tq+
         ubTw==
X-Gm-Message-State: AOAM530/0djKlsfEN6kMnR8JMejKdgAkNdYiy95mZO17IFlmQkjSNSmp
	TfShJ8sapOoLx9FdDUYnnlOyz3zwuZsBqhmZ
X-Google-Smtp-Source: ABdhPJx0SRjJ0QEpfNhPRSIr+BOOGvSzPp5MYvMnFq0surr+G3UghhXR7lVeCMTeEtWn11dUnOvX+Q==
X-Received: by 2002:a05:6808:190c:b0:32e:6d15:8859 with SMTP id bf12-20020a056808190c00b0032e6d158859mr10928190oib.48.1655493530337;
        Fri, 17 Jun 2022 12:18:50 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id a17-20020a4ad1d1000000b0035eb4e5a6b5sm3097680oos.11.2022.06.17.12.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 12:18:50 -0700 (PDT)
Message-ID: <8cbbedda-2716-e245-6d78-c13fbd91406b@gmail.com>
Date: Fri, 17 Jun 2022 14:15:05 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 06/15] test-runner: Support iwd-rtnl as a --verbose value
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
 <20220616000231.1966008-6-andrew.zaborowski@intel.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20220616000231.1966008-6-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 6/15/22 19:02, Andrew Zaborowski wrote:
> ---
>   tools/utils.py | 3 +++
>   1 file changed, 3 insertions(+)
> 

Patch 6-7 applied, thanks.

Regards,
-Denis

