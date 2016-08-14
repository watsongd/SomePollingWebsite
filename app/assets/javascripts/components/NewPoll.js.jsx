var NewPoll = React.createClass({
  getInitialState: function() {
    return {
      options: ["", "", "", ""],
      public: false,
    }
  },
  addOption: function(e) {
    e.preventDefault();
    this.state.options.push("");
    this.setState({
      options: this.state.options
    });
  },
  removeOption: function(index) {
    this.state.options.splice(index, 1);
    this.setState({
      options: this.state.options
    });
  },
  handleOptionsChange: function(index, e) {
    this.state.options[index] = e.target.value;
    this.setState({
      options: this.state.options
    });
  },
  handleRadioChangePublic: function(e) {
    e.preventDefault();
    this.setState({
      public: true
    });
  },
  handleRadioChangePrivate: function(e) {
    e.preventDefault();
    this.setState({
      public: false
    });
  },
  render: function() {
    let remove = this.removeOption;
    let handleOptionChange = this.handleOptionsChange;
    let options = this.state.options;
    var optionsInputs = this.state.options.map(function(option, index) {
      return (
        <div className="row" key={index}>
          <div className="col s1">
            <a className="btn-floating btn-large button-new" onClick={() => remove(index)}>
              <i className="material-icons">delete</i>
            </a>
          </div>
          <div className="col s11">
            <input key={index} id={index} name="poll[options][]" type="text" onChange={(evt) => handleOptionChange(index, evt)} value={options[index]} placeholder="Write option here"/>
          </div>
          <br />
        </div>
      );
    });
    return (
      <div className="row">
        <form className="col s12" action="/polls" id="new_poll" method="post">
          <input name="authenticity_token" type="hidden" value={this.props.authenticity_token} />
          <div className="input-field">
            <input id="poll_title" name="poll[title]" type="text" /><br />
            <label for="poll_title">Title</label>
          </div>
          <label>Options:</label>
          <br />
          {optionsInputs}
          <a className="btn" onClick={this.addOption}>
            Add Option
          </a>
          <p onClick={this.handleRadioChangePrivate} >
            <input type="radio" name="poll[public]" checked={!this.state.public} id="private" value={this.state.public} readOnly/>
            <label for="private">Private</label>
          </p>
          <p onClick={this.handleRadioChangePublic} >
            <input type="radio" name="poll[public]" checked={this.state.public} id="public" value={this.state.public} readOnly/>
            <label for="public">Public</label>
          </p>
          <button className="btn" name="commit" type="submit" value="Create Poll">
            Create Poll
            <i className="material-icons right">send</i>
          </button>
        </form>
      </div>
    );
  }
});