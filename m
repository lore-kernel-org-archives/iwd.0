Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F975398
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 17:52:48 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id j184so3933314pge.10
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=0qgSsAphOTLGcy5xZBUfEr0V4V2isYwG7mxsXPbWEGQ=;
        b=GSA/Gh9zsYVQNTa8DCyqtbfQe4NINgW54l/xSyGOGPOOCjYz//9Rxms2fjnwS+9i8y
         i0Zbe3bbpRKtUfolO2QZBrh7mvgWUwupAxA/uD4ZHmuFUuAapiNPXj9A5RIzZ7N5/shJ
         zX2p2WxqCclhg+KKVxOUQq2K2wxQq+Jrgldfg//mnMvegsBq15vXAoDqPfHT7eCj4xel
         Om6P4cC1bT4SO/19G4lWVsolQ0QsRl8s8O8OQBcTpFQh0Zh7ME2K6ElisK9OjAarFs1T
         MPBQkkcwixjN7w9BV77nD130EK/mUtizXwDYgfWFFR07KCFQXY47XNQ6ldZhRj2SliOL
         auww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0qgSsAphOTLGcy5xZBUfEr0V4V2isYwG7mxsXPbWEGQ=;
        b=bfRECP51aVtuPgOW/dXMwUJkhdxJKw38BO1+5jXFtPvo1UhIiL1gz/+QnLfyqUD2ZY
         ZpRomqnLyaD3msszwQegmnikd14TTpmKhH1QTSdHRxiRYIqCOfTzLA0CSZxeqZAZosvu
         GvGK85sYuEL/YEEyznuNiGYT0OPqB86EASNi0VUQ+FTP/OzHFXcqEGPaRfhiqOy9UHXq
         Bcuv6nPwqwcqqfDp3dQayMomV+l8dP95jde0BQxOzl5MG9OxUsBjhQ7F9Njpk42S/ReT
         XytoKqSTnoFzZ8WqT7hssEAYFzk2K3KvNkQFPiOKZ/QgbdTsJbGZolVKdsDRP0rQeM2U
         Ppmw==
X-Gm-Message-State: AJIora8fyvDxnBE4FfOzzcbdXfs0SdEwOc65AUAZa7dCUR7mGbQOr9EL
	1M1JPEXgrtnEfBvhYggJoSg=
X-Google-Smtp-Source: AGRyM1vT80ZKTMhxJWIk00RIipJGx5LgLSxxTCprXMiO6zXl2xx7an8adYl4avZuwGp0Fz1slKk1mA==
X-Received: by 2002:a63:f04a:0:b0:411:e30e:4d9a with SMTP id s10-20020a63f04a000000b00411e30e4d9amr25952970pgj.58.1657129966881;
        Wed, 06 Jul 2022 10:52:46 -0700 (PDT)
Received: from [192.168.254.55] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902b40200b00168dadc7354sm25795956plr.78.2022.07.06.10.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:52:46 -0700 (PDT)
Message-ID: <9427ce8032e264ecac49ac448b4fc0a29726781d.camel@gmail.com>
Subject: Re: [PATCH 4/5] autotests: Reuse HostapdCLI objects
From: James Prestwood <prestwoj@gmail.com>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>, iwd@lists.linux.dev
Date: Wed, 06 Jul 2022 10:52:45 -0700
In-Reply-To: <20220706165702.3241756-4-andrew.zaborowski@intel.com>
References: <20220706165702.3241756-1-andrew.zaborowski@intel.com>
	 <20220706165702.3241756-4-andrew.zaborowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-3.fc34) 
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Andrew,

On Wed, 2022-07-06 at 18:57 +0200, Andrew Zaborowski wrote:
> TestContext.start_hostapd() in tools/run-tests already creates
> HostapdCLI objects for every interface assigned to hostapd, try not to
> create new HostapdCLI instances for those interfaces in each test.
> ---

<snip>

So I very well could have done it wrong in the first place, but the
HostapdCLI class itself should handle this inside __new__().

Any new HostapdCLI class first checks if a duplicate object exists in
_instances (indexed by 'config'), and if so returns the same object.

Thanks,
James

