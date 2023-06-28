Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE610944
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 20:20:39 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7659924cd9bso14581685a.1
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687983638; x=1690575638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ds3AIKJdYU9mxZ5wbGsPiqfyuEOVWHHA5d0MbBGmWcQ=;
        b=KkW/wdWma8fLVlfmnFyECW8ceBF9YTDnGxC0AGiR7W/FGHdBEu3jz+S6uP6iPo7fPy
         EgWb6PbKbO04PHf99QzaP8jXLNzzC1f7JwQmUjFWsxIOW6Q/31vbKNdKFI6oD+af1Ctx
         Mo3vOBnG6jBQF5rFdhkSlsAVOZS1sC9dwLkJJ+kYlrMIR0w41HobjTQUcftvyO7cm5M0
         +jvsBmPS5R9Wv/cT37xQDtu4f6+oPkUP7kTD6TroDO5morwQPsH7um2oivjdf47LGmrO
         ObTqdXzB2ZBVo8lGYMANlRtuT7InQOwt/ZRjpNnEd3QPpTWlKE0dXEj7OeaIMATCo59t
         stcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983638; x=1690575638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ds3AIKJdYU9mxZ5wbGsPiqfyuEOVWHHA5d0MbBGmWcQ=;
        b=jdk100pj6ramY9deWts8zltyRkwsCqpz8GCBqZacGtg0A+EzUbskJ3y1f/LHCzOGzk
         6r/s5yHYvRU5IbpaDHYb7oakZq/nrKIVjag9PZAdgfp7zJYeD877fOcwr5xcKiXwWxRT
         vMwtxS94sLqT+Fgq+XEt4Iz/Sg0c5FmGRCO+2/rOciimB1NEIuf2JRb18/wgmpR6ERx+
         9yXBD63+tyMU00+KqyNPQP0igZRGTUvt14x66ILll4rbHh1oD9mf47yL4wxW5biCGohS
         DzczgzQxzYUs7Y9AnLQ4NzwJQDvSu+JLlt+3iWLW6bO4HYDviwy6srBbXHyFzSTIWsWf
         oAtg==
X-Gm-Message-State: AC+VfDwL9KplNXXIRIC1qAcLiN4o0pdO9y2GMU5eRgY38z37i/4NvTy3
	ieVKX8t6/mPTaJffG7nhb8jfe8ccccs=
X-Google-Smtp-Source: ACHHUZ7kEaZO7SEkQSaHONMmvkWM6LHG3LYIJemRq2Uo8UJPuk70z5nls016sf/1p8a6kELUOySWrw==
X-Received: by 2002:a37:ea09:0:b0:765:a77c:7219 with SMTP id t9-20020a37ea09000000b00765a77c7219mr10851447qkj.0.1687983638205;
        Wed, 28 Jun 2023 13:20:38 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i4-20020a05620a144400b0076728319575sm672557qkl.27.2023.06.28.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:20:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/3] Handle DEL/ADD_MAC_ADDR events
Date: Wed, 28 Jun 2023 13:20:30 -0700
Message-Id: <20230628202033.2320994-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So this did work all along, I was just looking at it the wrong way.
 - Scan randomization now works with hwsim
 - Radios can be moved to another namespace and still work correctly
   with hwsim

James Prestwood (3):
  hwsim: add ADD/DEL_MAC_ADDR events
  hwsim: move frame processing into a separate function
  hwsim: handle ADD/DEL_MAC_ADDR events

 tools/hwsim.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 158 insertions(+), 6 deletions(-)

-- 
2.25.1

