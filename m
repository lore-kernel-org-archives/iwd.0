Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3C53207
	for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 16:10:10 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so4070526pjg.1
        for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CxqcKe1O6K6D03Ds3rTEaLTEnXz08iv6x6jNdUUTIE=;
        b=kRrFCD5QCYogBB1sqDNUO/BGD8RJF5uRS4I9SUHA/ewrk0UVHCTOm3yeKUjh7yCd51
         Nwg83mAsVKJcE4CdM7QYpAlH/HRXWhPi5B7xRSHW5aMkZk5YMCu9WCJAPQjkEIvO8c2p
         DQ6lYShG7cByn7tvNbs3KiXwhJ5OLNddNWZsTJHJJbTBDtZffjrwZQ3LODtZV8GqLM6u
         UMqjr0XjYpVpLrEohKWEXxE1egkoQl2bqKkTzspg8ss1bN2hkWL88aSWDsWl5eLQfPor
         LN5JH8AnMutKV2Ld3gskzFZ2l8povwBaPMrLTehmfKYRmXgqGJrpkGIbt+zlx1tEcsQU
         ly6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5CxqcKe1O6K6D03Ds3rTEaLTEnXz08iv6x6jNdUUTIE=;
        b=HblSGS6/xMJlkOB9qFrxxufQdlVCscutZG5O8z/rYcEqOyX3OeZ4urkw4z0LV7VyHj
         S1XWkN6rFqKVbeT8G+3kOya5NXEqy+MPxXedgenA9o4B92HF5adj6wFuPRcvUr1pt8bb
         trw9tL+EbzywuMmJlxShlYxhDlqiW64B+F81KCiKU3YwJnp7wexUHhZaLL3JguxqsiqQ
         q/hOYzs03a/X1jFtwZVozS/3xTzp2d71Wl/ZBl7AaUCvH/7M7Y5f9NNVdI0PLDwP2mTk
         fuqiFxf5Tzc1UQHgdb+s2ZHyyabo8mPAtNe2SpclQbuZxVTPD6H9a0oxjHir/DFf8RAO
         PwOg==
X-Gm-Message-State: ACrzQf0YwwVTIbjFM4vznd0BiSMkOG8E1jR7sVmmgPsPvJdTxNAwFIMn
	8MN7TdlWaw9T0GN3MYLhuuV2Bap0EXI=
X-Google-Smtp-Source: AMsMyM7VGQy7F5YbuSwwCGJd0s9smCbEKTDd7S4vA7p3hkUMIEAsXUbK3CsEyputHtP3ofd8hx6d8w==
X-Received: by 2002:a17:903:189:b0:183:7473:57f1 with SMTP id z9-20020a170903018900b00183747357f1mr409628plg.28.1665418209903;
        Mon, 10 Oct 2022 09:10:09 -0700 (PDT)
Received: from localhost (114-41-39-105.dynamic-ip.hinet.net. [114.41.39.105])
        by smtp.gmail.com with ESMTPSA id t6-20020aa79466000000b005631af4ece2sm3858802pfq.182.2022.10.10.09.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 09:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Oct 2022 00:09:38 +0800
Message-Id: <CNIDH0YNL06Q.3B8CX0X2XUXID@xps>
Subject: Re: [PATCH] client: handle wide chars for table rows
From: "Pinghao Wu" <xdavidwuph@gmail.com>
To: "James Prestwood" <prestwoj@gmail.com>, <iwd@lists.linux.dev>
X-Mailer: aerc 0.12.0
References: <20221008075509.26252-1-xdavidwuph@gmail.com>
 <72fd6e3e0ee1ac040f4ad1af0dcffc5f693b3c5a.camel@gmail.com>
In-Reply-To: <72fd6e3e0ee1ac040f4ad1af0dcffc5f693b3c5a.camel@gmail.com>

The current non-codepoint UTF-8 method assumes that a codepoint occupies
one column while printing. This is not true for some characters like
Chinese characters, which occupies two columns.

The motivation of this patch is to handle these "wide" (in printing
columns) chars properly via wcwidth(). It's not actually about
non-UTF-8, but it is also useful for that case.
