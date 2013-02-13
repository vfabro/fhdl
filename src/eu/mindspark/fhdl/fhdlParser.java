// Generated from src/eu/mindspark/fhdl/fhdl.g4 by ANTLR 4.0
package eu.mindspark.fhdl;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class fhdlParser extends Parser {
	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		HI=1, PLANET=2, SPACE=3, QM=4, DOT=5, INT=6, WS=7;
	public static final String[] tokenNames = {
		"<INVALID>", "'hello'", "'world'", "' '", "'!'", "'.'", "INT", "WS"
	};
	public static final int
		RULE_r0 = 0, RULE_r1 = 1;
	public static final String[] ruleNames = {
		"r0", "r1"
	};

	@Override
	public String getGrammarFileName() { return "fhdl.g4"; }

	@Override
	public String[] getTokenNames() { return tokenNames; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public fhdlParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}
	public static class R0Context extends ParserRuleContext {
		public TerminalNode DOT() { return getToken(fhdlParser.DOT, 0); }
		public TerminalNode QM() { return getToken(fhdlParser.QM, 0); }
		public R1Context r1() {
			return getRuleContext(R1Context.class,0);
		}
		public R0Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_r0; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof fhdlListener ) ((fhdlListener)listener).enterR0(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof fhdlListener ) ((fhdlListener)listener).exitR0(this);
		}
	}

	public final R0Context r0() throws RecognitionException {
		R0Context _localctx = new R0Context(_ctx, getState());
		enterRule(_localctx, 0, RULE_r0);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(4); r1();
			setState(6);
			_la = _input.LA(1);
			if (_la==QM || _la==DOT) {
				{
				setState(5);
				_la = _input.LA(1);
				if ( !(_la==QM || _la==DOT) ) {
				_errHandler.recoverInline(this);
				}
				consume();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class R1Context extends ParserRuleContext {
		public List<TerminalNode> HI() { return getTokens(fhdlParser.HI); }
		public TerminalNode HI(int i) {
			return getToken(fhdlParser.HI, i);
		}
		public TerminalNode PLANET() { return getToken(fhdlParser.PLANET, 0); }
		public TerminalNode SPACE() { return getToken(fhdlParser.SPACE, 0); }
		public R1Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_r1; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof fhdlListener ) ((fhdlListener)listener).enterR1(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof fhdlListener ) ((fhdlListener)listener).exitR1(this);
		}
	}

	public final R1Context r1() throws RecognitionException {
		R1Context _localctx = new R1Context(_ctx, getState());
		enterRule(_localctx, 2, RULE_r1);
		try {
			setState(14);
			switch ( getInterpreter().adaptivePredict(_input,1,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(8); match(HI);
				setState(9); match(SPACE);
				setState(10); match(PLANET);
				}
				break;

			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(11); match(HI);
				setState(12); match(HI);
				setState(13); match(PLANET);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static final String _serializedATN =
		"\2\3\t\23\4\2\t\2\4\3\t\3\3\2\3\2\5\2\t\n\2\3\3\3\3\3\3\3\3\3\3\3\3\5"+
		"\3\21\n\3\3\3\2\4\2\4\2\3\3\6\7\22\2\6\3\2\2\2\4\20\3\2\2\2\6\b\5\4\3"+
		"\2\7\t\t\2\2\2\b\7\3\2\2\2\b\t\3\2\2\2\t\3\3\2\2\2\n\13\7\3\2\2\13\f\7"+
		"\5\2\2\f\21\7\4\2\2\r\16\7\3\2\2\16\17\7\3\2\2\17\21\7\4\2\2\20\n\3\2"+
		"\2\2\20\r\3\2\2\2\21\5\3\2\2\2\4\b\20";
	public static final ATN _ATN =
		ATNSimulator.deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
	}
}